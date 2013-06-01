
{% extends "tredius/views/templates/base.html" %}

{% block content %}

 {{navigation}}
 <div class="hero-unit">
    <h1>Welcome to tredius</h1>
    <p>Time to start building your site!</p>
    <p><a class="btn btn-primary btn-large" href="http://luminusweb.net">Learn more &raquo;</a></p>
 </div>

 <div class="row">
    <div class="span12">
    {{content}}
    </div>
 </div>


{% endblock %}
