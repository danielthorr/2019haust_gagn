import json

song_base = '''
[
    {
		"songID": "1001",
		"songName": "Susanne",
		"key": "E-major",
		"length": "03.49",
		"performer":"Leonard Cohen",
		"chords": ["Emaj","F#min","G#min","Amaj"],
		"musicians": ["Leonard Cohen","Jimmy Lovelace","Nancy Priddy","Willy Ruff","Chester Crill"]
	},
	{
		"songID": "1002",
		"songName": "In My Blood",
		"key": "D-major",
		"length": "03.47" ,
		"performer":"Black Stone Cherry",
		"chords": ["Dmaj","Amaj","Cmaj","Bmaj","Dsus2","Gadd9"],
		"musicians": ["Chris Robertson","Ben Wells","Jon Lawhon","John Fred Young"]
	},
	{
		"songID": "1003",
		"songName": "From the beginning",
		"key": "A-minor",
		"length": "04.13" ,
		"performer":"Emerson Lake & Palmer",
		"chords": ["Amin9","Emin11","Dmin7","Dmin6","Gmaj","Fmaj9","Cmaj9","E7sus4"],
		"musicians": [{"Keith Emerson":["Moog"]},{"Greg Lake":["Vocals","Accoustic Guitar","Bass"]},{"Carl Palmer":["Percussion"]}]
	}
]
'''

# Accessing various parts of a JSon document:

# get the songs into the data variable.
# It should be noted that song_base is a list of objects
# ALso notice that the third song has a different musician list than the others
data = json.loads(song_base)

# getting the songID from the first element in the list
print json.dumps(data[0]["songID"])
# get all of the musicans that are in the first list
print json.dumps(data[0]["musicians"])
# get the third musician in the first list
print json.dumps(data[0]["musicians"][2])
# get all the chords used in the second song
print json.dumps(data[1]["chords"])
# get the musicans int the third song
print json.dumps(data[2]["musicians"])
# get the second musican int the third song(Greg Lake)
print json.dumps(data[2]["musicians"][1])

# finally let's look at all the chords in all the songs :-)
for song in data:
    print song["chords"]