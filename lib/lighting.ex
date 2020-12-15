defmodule Lighting do
  @epsilon 0.001

  defp calculate_light_intensity(
         %AmbientLight{} = light,
         _intersection_normal,
         _intersection_point,
         _ray,
         _shape,
         _shadow_function
       ) do
    light.intensity
  end

  defp calculate_light_intensity(
         %DirectionalLight{} = light,
         intersection_normal,
         intersection_point,
         ray,
         shape,
         shadow_function
       ) do
    calculate_directional_light(
      light.direction,
      light.intensity,
      intersection_normal,
      intersection_point,
      ray,
      shape.material.specular,
      shadow_function,
      # Directional light goes forever
      :infinite
    )
  end

  defp calculate_light_intensity(
         %PointLight{} = light,
         intersection_normal,
         intersection_point,
         ray,
         shape,
         shadow_function
       ) do
    light_vector = Vector3.subtract(light.position, intersection_point)

    calculate_directional_light(
      light_vector,
      light.intensity,
      intersection_normal,
      intersection_point,
      ray,
      shape.material.specular,
      shadow_function,
      # Only goes in 1 direction
      1
    )
  end

  defp calculate_directional_light(
         %Vector3{} = lighting_vector,
         intensity,
         intersection_normal,
         intersection_point,
         ray,
         shininess,
         shadow_function,
         t_max
       ) do
    if in_shadow(intersection_point, lighting_vector, shadow_function, t_max) do
      0
    else
      calculate_diffuse_lighting(lighting_vector, intensity, intersection_normal) +
        calculate_specular_lighting(
          lighting_vector,
          intersection_normal,
          ray,
          intensity,
          shininess
        )
    end
  end

  defp in_shadow(intersection_point, lighting_vector, shadow_function, t_max) do
    case shadow_function.(intersection_point, lighting_vector, @epsilon, t_max) do
      nil -> false
      _ -> true
    end
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
    reflection_direction = Vector3.reflect_ray(intersection_normal, lighting_vector)

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

  def calculate_lighting(
        scene,
        intersection_normal,
        intersection_point,
        ray,
        shape,
        shadow_function
      ) do
    Enum.reduce(scene.lights, 0, fn light, acc ->
      acc +
        calculate_light_intensity(
          light,
          intersection_normal,
          intersection_point,
          ray,
          shape,
          shadow_function
        )
    end)
  end
end
