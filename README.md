Just Books Library API
============

This application provides API for books library with simple full text search on books name and genre, author name, reviewer name.

Requirements
--------

Ruby and Rails

	Ruby version <b>2.3.1</b> and Rails version <b>5.1.4</b>

Database

	MongoDB


API documentation
--------
``` ruby
1. WS name: Sign Up

POST /api/v1/users/sign_up HTTP/1.1

Host: localhost:3000

Content-Type: application/json

Request:
{
	"user" : {
		"email" : "amit@example.com",
		"password" : "xxxxxxxx"
	}
}

Response:
{
    "status": 200,
    "message": "Successfully signed up",
    "email": "amit@example.com"
}
```
``` ruby
2. WS name: Sign In

POST /api/v1/users/sign_in HTTP/1.1

Host: localhost:3000

Content-Type: application/json

Request body:
{
	"user" : {
		"login" : "amit_mhetre@ymail.com",
		"password" : "xxxxxxxx"
	}
}

Response:
{
    "status": 200,
    "message": "Successfully signed in",
    "login": "amit@example.com",
    "token": "Bearer xxxxxxxx"
}
```
``` ruby
3. WS name: Book search

POST /api/v1/books/search?page=PAGE_NUMBER HTTP/1.1

Host: localhost:3000

Authorization: Bearer xxxxxxxx

Content-Type: application/json

Request:
{
	"keyword" : "Daffodil"
}

Response:
{
    "status": 200,
    "message": "Successfully fetched books",
    "pages" : 1,
    "payload": [
        {
            "_id": {
                "$oid": "59e39fd141a5f0330e5a0dc3"
            },
            "genre": "Action and Adventure",
            "name": "The Daffodil Sky",
            "publication_date": "2017-10-02",
            "short_desc": "Quia voluptatem corrupti veniam sed nulla."
        }
    ]
}
```
