#ifdef GL_ES
precision mediump float;
#endif

#define M_PI 3.1415926535897932384626433832795

uniform float u_time;

uniform float u_angle;
uniform float u_distance;

uniform float u_waves_number;

varying vec2 v_uv;



float toRadians( float angle ) {
    return angle * ( M_PI / 180.0 );
}


void main() {



    // Création de différents points
    vec2 center_coords = v_uv - 0.5;
    
    vec2 left_coords = vec2( v_uv.x - 1.5, v_uv.y ) * 1.1;
    vec2 right_coords = vec2( v_uv.x + 1.5, v_uv.y ) * 0.7;

    vec2 top_coords = vec2( v_uv.x, v_uv.y + 1.5 ) * 1.4;
    vec2 bottom_coords = vec2( v_uv.x, v_uv.y - 1.5 ) * 1.3;

    

    // Distance des points
    float dist_from_left = length( left_coords );
    float dist_from_right = length( right_coords );
    float dist_from_top = length( top_coords );
    float dist_from_bottom = length( bottom_coords );
    float dist_from_center = length( center_coords );


    // Création du "Fond bleu"
    vec3 fond = vec3( 0.0, 0.0, 1.0 );
    

    // Vitesse des ondes
    float speed = u_time / 80.0;

    float factor = 3.0; 



    float zWave_left = sin( (dist_from_left * u_waves_number * 0.5) - speed * 3.0 ) * factor;
    float zWave_right = sin( (dist_from_right * u_waves_number) - speed * 1.5 ) * factor;
    float zWave_top = sin( (dist_from_top * u_waves_number * 0.4) - speed ) * factor;
    float zWave_bottom = sin( (dist_from_bottom * u_waves_number) - speed * 0.4 ) * factor;


    float zWave_center = sin( (dist_from_center * u_waves_number) - speed  ) * factor;

    float zWave = zWave_center;

    vec3 colorWave = vec3( zWave, zWave, zWave );



    float edge_distance = u_distance - zWave;
    float refractionOffset = sin ( toRadians( u_angle ) ) * edge_distance;
    vec2 offset_coords = center_coords - refractionOffset;

    float offset_dist = length( offset_coords );


    // SOLEIL "troublé"
    vec3 sun = vec3( 1.0 - offset_dist, 1.0 - offset_dist, 1.0 - offset_dist );
    vec3 suncolor = fond + sun;

    
    // Couleur du fragment
    gl_FragColor = vec4(suncolor, 1.0);    

}