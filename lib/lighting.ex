defmodule Lighting do
  defp calculate_light_intensity(
         %AmbientLight{} = light,
         _intersection_normal,
         _intersection_point,
         _ray,
         _shape
       ) do
    light.intensity
  end

  defp calculate_light_intensity(
         %DirectionalLight{} = light,
         intersection_normal,
         _intersection_point,
         ray,
         shape
       ) do
    calculate_directional_light(
      light.direction,
      light.intensity,
      intersection_normal,
      ray,
      shape.material.specular
    )
  end

  defp calculate_light_intensity(
         %PointLight{} = light,
         intersection_normal,
         intersection_point,
         ray,
         shape
       ) do
    light_vector = Vector3.subtract(light.position, intersection_point)

    calculate_directional_light(
      light_vector,
      light.intensity,
      intersection_normal,
      ray,
      shape.material.specular
    )
  end

  defp calculate_directional_light(
         %Vector3{} = lighting_vector,
         intensity,
         intersection_normal,
         ray,
         shininess
       ) do
    calculate_diffuse_lighting(lighting_vector, intensity, intersection_normal) +
      calculate_specular_lighting(lighting_vector, intersection_normal, ray, intensity, shininess)
  end

  defp calculate_diffuse_lighting(%Vector3{} = lighting_vector, intensity, intersection_normal) do
    lighting = Vector3.dot(intersection_normal, lighting_vector)

    if(lighting > 0) do
      intensity * lighting /
        (Vector3.vector_length(intersection_normal) * Vector3.vector_length(lighting_vector))
    else
      0
    end
  end

  defp calculate_specular_lighting(
         %Vector3{} = lighting_vector,
         intersection_normal,
         ray,
         light_intensity,
         shiny
       ) do
    reflection_direction =
      Vector3.scale(intersection_normal, 2 * Vector3.dot(intersection_normal, lighting_vector))
      |> Vector3.subtract(lighting_vector)

    reflection_dot_view = Vector3.dot(reflection_direction, ray)

    if(reflection_dot_view > 0) do
      light_intensity *
        :math.pow(
          reflection_dot_view /
            (Vector3.vector_length(reflection_direction) *
               Vector3.vector_length(ray)),
          shiny
        )
    else
      0
    end
  end

  def calculate_lighting(scene, intersection_normal, intersection_point, ray, shape) do
    Enum.reduce(scene.lights, 0, fn light, acc ->
      acc + calculate_light_intensity(light, intersection_normal, intersection_point, ray, shape)
    end)
  end
end
