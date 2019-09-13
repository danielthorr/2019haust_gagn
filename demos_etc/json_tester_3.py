import json

# we start by creating a json formatted data
song_base = '''
[
    {
		"songID": "1001",
		"songName": "Susanne",
		"key": "E-major",
		"length": "03.49",
		"performer":"Leonard Cohen"
	},
	{
		"songID": "1002",
		"songName": "In My Blood",
		"key": "D-major",
		"length": "03.47" ,
		"performer":"Black Stone Cherry"
	},
	{
		"songID": "1003",
		"songName": "From the beginning",
		"key": "A-minor",
		"length": "04.13" ,
		"performer":"Emerson Lake & Palmer"
	},
	{
		"songID": "1004",
		"songName": "Crying like a Bitch",
		"key": "D-major",
		"length": "03.22" ,
		"performer":"Godscmack"
	},
	{
		"songID": "1005",
		"songName": "Wish you were here",
		"key": "G-major",
		"length": "05.35" ,
		"performer":"Pink Floyd"
	}
]
'''
# we load this data into a variable
song_list = json.loads(song_base)

# a samm function to search for a song name based on the song id
def find_song_name(song_id,the_list):
    song_name = 'Song not found'
    for song in the_list:
        if song["songID"] == song_id:
            song_name = song["songName"]
            break
    return song_name

# function tests.
print find_song_name("1004", song_list)
print find_song_name("5432", song_list)