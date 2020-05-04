defmodule ID3Parser do
  def parse(file_name) do
    case File.read(file_name) do # read file
      {:ok, mp3} -> # read successful
        mp3_byte_size = byte_size(mp3) - 128 # calculate the audio portion

        << _ :: binary-size(mp3_byte_size), id3_tag :: binary >> = mp3 # pattern matches the MP3 binary to capture the bytes of the ID3 tag

        << "TAG", title :: binary-size(30),
                  artist :: binary-size(30),
                  album :: binary-size(30),
                  year :: binary-size(4),
                  _rest :: binary >> = id3_tag

        IO.puts "#{artist} - #{title} (#{album}, #{year})"

      _ ->
        IO.puts "Couldn't open #{file_name}"
    end
  end
end
