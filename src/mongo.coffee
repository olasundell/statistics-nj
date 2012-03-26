http = require('http')
url = require('url')
mongodb = require('mongodb')

mongourl = 'mongodb://localhost:27017/db'

writeToMongo = (err, conn) ->
	conn.collection('ips', (err, coll) ->
		insObj = { 'ip': req.connection.remoteAddress, 'ts': new Date(), 'category': 'foo'}
		coll.insert( insObj, {safe:true}, (err) ->
			res.writeHead(200, {'Content-Type': 'text/plain'})
			res.write(JSON.stringify(insObj))
			res.end('\n')
		)
	)

record_visit = (req, res) ->
	throw 'foo' if url.parse(req.url).query == null
	mongodb.connect(mongourl, writeToMongo)


server = http.createServer(record_visit)

server.listen(3000)

console.log('Now listening on port 3000')
