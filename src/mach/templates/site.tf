# This file is auto-generated by MACH composer
# Site: {{ site.identifier }}

terraform {
  {% if general_config.terraform_config.azure_remote_state %}
  {% set azure_config = general_config.terraform_config.azure_remote_state %}
  backend "azurerm" {
    resource_group_name  = "{{ azure_config.resource_group_name }}"
    storage_account_name = "{{ azure_config.storage_account_name }}"
    container_name       = "{{ azure_config.container_name }}"
    key                  = "{{ azure_config.state_folder}}/{{ site.identifier }}"
  }
  {% elif general_config.terraform_config.aws_remote_state %}
  {% set aws_config = general_config.terraform_config.aws_remote_state %}
  backend "s3" {
    bucket         = "{{ aws_config.bucket}}"
    key            = "{{ aws_config.key_prefix}}/{{ site.identifier }}"
    region         = "{{ aws_config.region }}"
    role_arn       = "{{ aws_config.role_arn }}"
    {% if aws_config.lock_table %}
    dynamodb_table = "{{ aws_config.lock_table }}"
    {% endif %}
  }
  {% endif %}
}

{% include 'partials/commercetools.tf' %}

{% if site.aws %}{% include 'partials/aws.tf' %}{% endif %}
{% if site.azure %}{% include 'partials/azure.tf' %}{% endif %}

{% include 'partials/components.tf' %}