import json

# load the json file like any normal file and put it in the variable song_list.
# Note here that json.load is not the same as json.loads
# the 's' at the end means to load the file as string(when the json data is within a string)
with open('data/song_base.json') as json_data:
    song_list = json.load(json_data)


def find_song_name(song_id,the_list):
    song_name = 'Song not found'
    for song in the_list:
        if song["songID"] == song_id:
            song_name = song["songName"]
            break
    return song_name

print find_song_name("1004", song_list)
print find_song_name("5432", song_list)