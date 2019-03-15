import requests
import json

def initial_webpage_reading():
    '''
    Purpose: read the webpage contents once the alfalfa/boptest is running
    Inputs: None
    Returns: webpage contents, containing the haystack id/name/dis...
    Notes: we return the id of interested haystack points
    '''
    #url = "http://localhost/sites" #this one only shows the static web contents
    url = "http://localhost/api/read"
    header = { "Accept":"application/json", "Content-Type":"text/zinc" }
    payload_001 = 'ver:"2.0"'
    payload_002 = 'filter, limit'
    payload_003 = '"point",1000'
    data = payload_001 +'\n'+ payload_002 +'\n' + payload_003 + '\n'    
    print (data)
 
    reading_response = requests.post(url=url, headers=header, data=data)
    print ( reading_response.status_code, reading_response.text )


def send_reading_requests(point_id_readable):
    '''
    Purpose: receive responses of http-reading-requests for Haystack point
    Inputs: point_id_readable
    Returns: http-reading-request status
    Notes: url ="http://localhost:80/api/read"; header and data need to follow Haystack syntax
    '''
    url    = "http://localhost:80/api/read"
    header = { "Accept":"application/json", "Content-Type":"text/zinc" }
  
    payload_001 = 'ver:"2.0"'
    payload_002 = 'filter, limit'
    payload_003 = '"id==@' + point_id_readable + '",1000'
    data = payload_001 +'\n'+ payload_002 +'\n' + payload_003 + '\n'
    
    reading_response = requests.post(url=url, headers=header, data=data)
     
    print (reading_response.status_code, '\n', \
           reading_response.content, '\n', \
           reading_response.text)


def send_writing_requests(point_id_writable):
    '''
    Purpose: receive responses of http-writing-requests for Haystack point
    Inputs: point_id_writable
    Returns: http-writing-request status
    Notes: url ="http://localhost:80/api/pointWrite"; header and data need to follow Haystack syntax
    '''
    url    = "http://localhost:80/api/pointWrite"
    header = { "Accept":"application/json", "Content-Type":"application/json; charset=utf-8" }
    data = json.dumps(
        {
            "meta": {"ver":"2.0"},
            "rows": [ { "id" :"r:" + point_id_writable, \
            "level": "n:1", \
            "who" : "s:" , \
            "val" : "n:0.777",\
            "duration": "s:"
                      }
                    ],
            "cols": [ {"name":"id"}, {"name":"level"}, {"name":"val"}, {"name":"who"}, {"name":"duration"} ]
        }
    )

    writing_response = requests.post(url=url, headers=header, data=data)

    print (writing_response.content)


##########################################################################
########   Main Entry for Http requests  
##########################################################################
id_writable = "de76b6c3-3e45-4d0a-926b-1a29e133508d"
send_writing_requests(id_writable)

#id_readable = "f8f9ae2d-772a-4464-9bec-8c1e3fb4b488"
#send_reading_requests(id_readable )

initial_webpage_reading()

