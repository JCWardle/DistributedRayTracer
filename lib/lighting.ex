defmodule Lighting do
    def calculate_light_intensity(%AmbientLight{} = light, intersection_point) do
        light.intensity
    end

    def calculate_lighting(scene, intersection_point) do
        #normal = intersection_point.normal
        #intersection = intersection_point.intersection
        Enum.reduce(scene.lights, 0, fn light, acc -> 
            acc + calculate_light_intensity(light, intersection_point)
        end)    
    end
end
