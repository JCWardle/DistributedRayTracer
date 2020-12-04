import Mogrify

defmodule Output do
    def write_to_file(file_name, pixels, width, height) do
        {:ok, file} = File.open(file_name, [:write])
        png = :png.create(
            %{:size => {width + 1, height+ 1}, 
            :mode => {:rgb, 8}, 
            :file => file}
        )

        rows = Enum.group_by(pixels, fn(pixel) -> 
            pixel.y
        end)
        |> Enum.sort()
        |> Enum.reverse()

        Enum.each(rows, fn({row_number, row_pixels}) -> 
            row = Enum.map(row_pixels, fn(pixel) ->
                Colour.to_binary(pixel.colour)
            end)
            :png.append(png, {:row, row})
        end)
        :png.close(png) 
    end
end
