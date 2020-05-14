import Mogrify

defmodule Output do
    def write_to_file(file_name, pixels, width, height) do
        {:ok, file} = File.open(file_name, [:write])
        png = :png.create(
            %{:size => {5, 5}, 
            :mode => {:rgb, 8}, 
            :file => file}
        )

        #Make row
        row = [<<0,0,0>>,<<0,0,0>>,<<0,0,0>>,<<0,0,0>>,<<0,0,0>>]
        :png.append(png, {:row, row})
        row = [<<0,0,0>>,<<0,0,0>>,<<0,0,0>>,<<0,0,0>>,<<0,0,0>>]
        :png.append(png, {:row, row})
        row = [<<255,255,255>>,<<255,255,255>>,<<255,255,255>>,<<255,255,255>>,<<255,255,255>>]
        :png.append(png, {:row, row})
        row = [<<255,255,255>>,<<255,255,255>>,<<255,255,255>>,<<255,255,255>>,<<255,255,255>>]
        :png.append(png, {:row, row})
        row = [<<0,0,0>>,<<0,0,0>>,<<0,0,0>>,<<0,0,0>>,<<0,0,0>>]
        :png.append(png, {:row, row})

        :png.close(png) 
    end
end
