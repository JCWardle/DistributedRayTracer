defmodule Sphere do
    defstruct   radius: nil,
                position: nil, # The center of the sphere
                colour: nil

    # https://www.gabrielgambetta.com/computer-graphics-from-scratch/basic-ray-tracing.html
    def check_collision(%Sphere{} = sphere, %Vector3{} = camera_position, %Vector3{} = direction) do
        sphere_center = sphere.position
        sphere_radius = sphere.radius
        oc = Vector3.subtract(camera_position, sphere_center)

        k1 = Vector3.dot(direction, direction)
        k2 = 2 * Vector3.dot(oc, direction)
        k3 = Vector3.dot(oc, oc) - sphere_radius * sphere_radius

        discriminant = k2*k2 - 4*k1*k3
        if(discriminant < 0) do
            nil
        else
            t1 = (-k2 + :math.sqrt(discriminant)) / (2 * k1)
            t2 = (k2 - :math.sqrt(discriminant)) / (2 * k1)
            {t1, t2}
        end
    end
end