defmodule Vector3 do
  import Math

  defstruct x: nil,
            y: nil,
            z: nil

  def new(x, y, z) do
    %Vector3{x: x, y: y, z: z}
  end

  def subtract(%Vector3{} = a, %Vector3{} = b) do
    new(a.x - b.x, a.y - b.y, a.z - b.z)
  end

  def add(%Vector3{} = a, %Vector3{} = b) do
    new(a.x + b.x, a.y + b.y, a.z + b.z)
  end

  def scale(%Vector3{} = a, scale) do
    new(a.x * scale, a.y * scale, a.z * scale)
  end

  def normalize(%Vector3{} = a) do
    length = vector_length(a)

    new(
      a.x / length,
      a.y / length,
      a.z / length
    )
  end

  def vector_length(%Vector3{} = a) do
    Math.sqrt(square(a.x) + square(a.y) + square(a.z))
  end

  defp square(a) do
    a * a
  end

  def dot(a, b) do
    a.x * b.x + a.y * b.y + a.z * b.z
  end
end
