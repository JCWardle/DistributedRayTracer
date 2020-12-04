defmodule Lighting do
  defp calculate_light_intensity(%AmbientLight{} = light, intersection_point) do
    light.intensity
  end

  defp calculate_light_intensity(%DirectionalLight{} = light, intersection_point) do
    lighting = Vector3.dot(intersection_point, light.direction)

    if(lighting > 0) do
      light.intensity * lighting /
        (Vector3.vector_length(intersection_point) * Vector3.vector_length(light.direction))
    else
      0
    end
  end

  def calculate_lighting(scene, intersection_point) do
    # normal = intersection_point.normal
    # intersection = intersection_point.intersection
    Enum.reduce(scene.lights, 0, fn light, acc ->
      acc + calculate_light_intensity(light, intersection_point)
    end)
  end
end
