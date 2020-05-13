defmodule Output do
    def write_to_file(file_name, pixels, width, height) do
        File.rm(file_name)
        # {:ok, file} = File.open("test.ppm", [:write, :utf8])
        pixel_stream = Stream.map(pixels, fn (pixel) ->
            "#{pixel.r}\t#{pixel.g}\t#{pixel.b}\n"
        end)
        Stream.concat(["P3\n#{width}\t#{height}\n255\n"], pixel_stream)
        |> Stream.into(File.stream!(file_name, [:write, :utf8]))
        |> Stream.run
    end
end
