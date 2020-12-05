defmodule Sphere do
  defstruct radius: nil,
            # The center of the sphere
            position: nil,
            colour: nil

  # https://www.gabrielgambetta.com/computer-graphics-from-scratch/basic-ray-tracing.html
  def check_collision(%Sphere{} = sphere, %Vector3{} = camera_position, %Vector3{} = direction) do
    sphere_center = sphere.position
    sphere_radius = sphere.radius
    oc = Vector3.subtract(camera_position, sphere_center)

    k1 = Vector3.dot(direction, direction)
    k2 = 2 * Vector3.dot(oc, direction)
    k3 = Vector3.dot(oc, oc) - sphere_radius * sphere_radius

    discriminant = k2 * k2 - 4 * k1 * k3

    if(discriminant < 0) do
      nil
    else
      t1 = (-k2 + :math.sqrt(discriminant)) / (2 * k1)
      t2 = (-k2 - :math.sqrt(discriminant)) / (2 * k1)
      # should this only return the smallest t value? which is the cloest intersection
      t1_p = Vector3.add(camera_position, Vector3.scale(direction, t1))
      t1_normal = Vector3.normalize(Vector3.subtract(t1_p, sphere.position))

      t2_p = Vector3.add(camera_position, Vector3.scale(direction, t2))
      t2_normal = Vector3.normalize(Vector3.subtract(t2_p, sphere.position))
      {%{:t => t1, :normal => t1_normal}, %{:t => t2, :normal => t2_normal}}
    end
  end
end
