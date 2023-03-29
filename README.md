# DM_IndividualAssignment2



Forward rendering involves the rendering of every object and applying light to it. Then with deferred rendering, the rendering is (to a small amount) deferred until all the geometries have passed down the pipe; the last image is then made by applying a shader(s) at the end of the pipeline. 
 
![Screenshot 2023-03-28 121316](https://user-images.githubusercontent.com/58942233/228303417-1f59bdda-72d9-4dcf-8c2f-03a545f233ce.png)


Task 2:

Screenshot of the gamescreen recreation and the assigned toon-ramp water shader with square waves:

![Screenshot 2023-03-28 202206](https://user-images.githubusercontent.com/58942233/228395461-bf118b2c-249a-4008-a2d0-d29f16f3c765.png)

The shader for the water was implemented by first establishing properties of the color, texture, as well as the wave amplitude, frequency, and speed. To use the toon ramp texture, I imported the LightingRamp method from the ToonRamp shader I have used previously. This method uses the dot product of the surface normal and light direction, diffuse lighting, ramp effect with the colors of the diffuse lighting, and the creation of the final outputted colors. The main difference between this and the previous shader I used for toon ramp is mainly the usage of the vertex shader. Here I use the equation of the wave amplitude multipled by the sin angle of the vertex x coordinates added to the time and wave speed and multiplied by the frequency. I then used a series of if and else statements to tightly control the float value of the displacment to maintain a square structure to the waves. The vertex shader ends with the output of the vertex coordinates' graph positions (x,y,z,w) being affected by this. The rest of the shader is a standard struct input (which outputs the uv coordinates) and surface output function (which outputs the color of the texture).  


Task 3:

![image](https://user-images.githubusercontent.com/58942233/228400064-ddf3b9ed-a695-4fa2-91a0-f76fb7f9b0fa.png)

The code piece above is focuse on a method unity uses when the main camera renders an image. It first divides the height and width of the source image by a integer range. It then gets the format of the image. It makes an 16-member array of the render textures. A temporary rendertexture is made and is assigned to first member of the previously made array and current destination. The current destination then has the source image copied into it and has the current source assigned to it. Then, the current source is copied to the destination image. Then the temporary render texture is released. 

![image](https://user-images.githubusercontent.com/58942233/228401001-045d78d9-bb3c-4ec3-87e7-8d3b1e596172.png)

The code piece above first has a for loop repeating for every iteration. It takes the half of the width and height, makes a temporary render texture and assigns it to the current destination. It then has an if condition that exits the loop if the height is less than 2. Then another temp render texture is made and assigned to current destination. The current source is then copied into the current destination. The temp rendertexture is released followed by current destination being assigned to the current source. Then the 2nd for loop runs for every iteration. It copies the current source to the current destination, then it releases the temporary render texture and assigns the current destination to the source.

![image](https://user-images.githubusercontent.com/58942233/228401809-baa51a2c-e154-4bbe-8ef6-c919feab41f2.png)

The last code piece above starts with a for loop running for every i - 2 times decrementally. It first assigns each texture to current destination. It then sets them to null. This is followed by the source being copied into the current destination. The temporary render texture is released. Then the current source has the current destination assigned to it. The current source is then copied into the destination image. 

This code could definitely be used to project several texture images onto a single object in a unity project. 
