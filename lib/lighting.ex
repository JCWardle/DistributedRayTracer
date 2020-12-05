defmodule Lighting do
  defp calculate_light_intensity(
         %AmbientLight{} = light,
         _intersection_normal,
         _intersection_point
       ) do
    light.intensity
  end

  defp calculate_light_intensity(
         %DirectionalLight{} = light,
         intersection_normal,
         _intersection_point
       ) do
    calculate_point_lighting(light.direction, light.intensity, intersection_normal)
  end

  defp calculate_light_intensity(%PointLight{} = light, intersection_normal, intersection_point) do
    light_vector = Vector3.subtract(light.position, intersection_point)
    calculate_point_lighting(light_vector, light.intensity, intersection_normal)
  end

  defp calculate_point_lighting(%Vector3{} = lighting_vector, intensity, intersection_normal) do
    lighting = Vector3.dot(intersection_normal, lighting_vector)

    if(lighting > 0) do
      intensity * lighting /
        (Vector3.vector_length(intersection_normal) * Vector3.vector_length(lighting_vector))
    else
      0
    end
  end

  def calculate_lighting(scene, intersection_normal, intersection_point) do
    # normal = intersection_normal.normal
    # intersection = intersection_normal.intersection
    Enum.reduce(scene.lights, 0, fn light, acc ->
      acc + calculate_light_intensity(light, intersection_normal, intersection_point)
    end)
  end
end
