# DM_IndividualAssignment2



Forward rendering involves the rendering of every object and applying light to it. Then with deferred rendering, the rendering is (to a small amount) deferred until all the geometries have passed down the pipe; the last image is then made by applying a shader(s) at the end of the pipeline. 
 
![Screenshot 2023-03-28 121316](https://user-images.githubusercontent.com/58942233/228303417-1f59bdda-72d9-4dcf-8c2f-03a545f233ce.png)


Task 2:

Screenshot of the gamescreen recreation and the assigned toon-ramp water shader with square waves:

![Screenshot 2023-03-28 202206](https://user-images.githubusercontent.com/58942233/228395461-bf118b2c-249a-4008-a2d0-d29f16f3c765.png)

The shader for the water was implemented by first establishing properties of the color, texture, as well as the wave amplitude, frequency, and speed. To use the toon ramp texture, I imported the LightingRamp method from the ToonRamp shader I have used previously. This method uses the dot product of the surface normal and light direction, diffuse lighting, ramp effect with the colors of the diffuse lighting, and the creation of the final outputted colors. The main difference between this and the previous shader I used for toon ramp is mainly the usage of the vertex shader. Here I use the equation of the wave amplitude multipled by the sin angle of the vertex x coordinates added to the time and wave speed and multiplied by the frequency. I then used a series of if and else statements to tightly control the float value of the displacment to maintain a square structure to the waves. The vertex shader ends with the output of the vertex coordinates' graph positions (x,y,z,w) being affected by this. The rest of the shader is a standard struct input (which outputs the uv coordinates) and surface output function (which outputs the color of the texture).  
