{% for component_endpoint, site_endpoint in component.endpoints.items() -%}
endpoint_{{ component_endpoint|slugify }} = {
  url = local.endpoint_url_{{ site_endpoint|slugify }}
  api_gateway_id = aws_apigatewayv2_api.{{ site_endpoint|slugify }}_gateway.id
  api_gateway_execution_arn = aws_apigatewayv2_api.{{ site_endpoint|slugify }}_gateway.execution_arn
}
{% endfor %}

{% if definition.artifacts %}
artifacts = {
  {% for name, artifact in definition.artifacts.items() -%}
  {{ name }} = "{{ artifact.filename }}"
  {% endfor %}
}
{% endif %}
