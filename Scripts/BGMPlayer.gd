extends AudioStreamPlayer

const levelMusic = preload("res://Assets/AudioClips/Possibility-V2.ogg")

func PlayMusic(audioClip : AudioStream, volume = -15.0):
	if stream == audioClip:
		return
		
	stream = audioClip
	volume_db = volume
	play()

func PlayLevelMusic():
	PlayMusic(levelMusic)
