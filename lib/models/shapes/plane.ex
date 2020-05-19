defmodule Plane do
    defstruct   position: nil,
                angle: nil, #The normal to the plane should be normalised
                colour: nil

    # https://www.scratchapixel.com/lessons/3d-basic-rendering/minimal-ray-tracer-rendering-simple-shapes/ray-plane-and-ray-disk-intersection
    def check_collision(%Plane{} = plane, %Vector3{} = camera_position, %Vector3{} = direction) do
        denominator = Vector3.dot(direction, plane.angle)

        if(denominator > 0.001) do # This is because it gets closer and closer there might not be a solution
            nominator = Vector3.dot(Vector3.subtract(plane.position, camera_position), plane.angle)
            t = nominator / denominator

            # Colision position
            # p = camera_position + Vector3.scale(direction, t)
            # normal = Vector3.normal(p)

            %{:t => t, :normal => nil}
        else 
            nil
        end
    end
end