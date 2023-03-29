# DM_IndividualAssignment2



Forward rendering involves the rendering of every object and applying light to it. Then with deferred rendering, the rendering is (to a small amount) deferred until all the geometries have passed down the pipe; the last image is then made by applying a shader(s) at the end of the pipeline. 
 
![Screenshot 2023-03-28 121316](https://user-images.githubusercontent.com/58942233/228303417-1f59bdda-72d9-4dcf-8c2f-03a545f233ce.png)


Task 3:

Screenshot of the gamescreen recreation and the assigned toon-ramp water shader with square waves:

![Screenshot 2023-03-28 202206](https://user-images.githubusercontent.com/58942233/228395461-bf118b2c-249a-4008-a2d0-d29f16f3c765.png)

The shader for the water was implemented by first establishing properties of the color, texture, as well as the wave amplitude, frequency, and speed. To use the toon ramp texture, I imported the LightingRamp method from the ToonRamp shader I have used previously. This method uses the dot product of the surface normal and light direction, diffuse lighting, ramp effect with the colors of the diffuse lighting, and the creation of the final outputted colors. The main difference between this and the previous shader I used for toon ramp is mainly the usage of the vertex shader. Here I use the equation of the wave amplitude multipled by the sin angle of the vertex x coordinates added to the time and wave speed and multiplied by the frequency. I then used a series of if and else statements to tightly control the float value of the displacment to maintain a square structure to the waves. The vertex shader ends with the output of the vertex coordinates' graph positions (x,y,z,w) being affected by this. The rest of the shader is a standard struct input (which outputs the uv coordinates) and surface output function (which outputs the color of the texture).  


Task 4:

![image](https://user-images.githubusercontent.com/58942233/228400064-ddf3b9ed-a695-4fa2-91a0-f76fb7f9b0fa.png)

The code piece above is focuse on a method unity uses when the main camera renders an image. It first divides the height and width of the source image by a integer range. It then gets the format of the image. It makes an 16-member array of the render textures. A temporary rendertexture is made and is assigned to first member of the previously made array and current destination. The current destination then has the source image copied into it and has the current source assigned to it. Then, the current source is copied to the destination image. Then the temporary render texture is released. 

![image](https://user-images.githubusercontent.com/58942233/228401001-045d78d9-bb3c-4ec3-87e7-8d3b1e596172.png)

The code piece above first has a for loop repeating for every iteration. It takes the half of the width and height, makes a temporary render texture and assigns it to the current destination. It then has an if condition that exits the loop if the height is less than 2. Then another temp render texture is made and assigned to current destination. The current source is then copied into the current destination. The temp rendertexture is released followed by current destination being assigned to the current source. Then the 2nd for loop runs for every iteration. It copies the current source to the current destination, then it releases the temporary render texture and assigns the current destination to the source.

![image](https://user-images.githubusercontent.com/58942233/228401809-baa51a2c-e154-4bbe-8ef6-c919feab41f2.png)

The last code piece above starts with a for loop running for every i - 2 times decrementally. It first assigns each texture to current destination. It then sets them to null. This is followed by the source being copied into the current destination. The temporary render texture is released. Then the current source has the current destination assigned to it. The current source is then copied into the destination image. 

This code could definitely be used to project several texture images onto a single object in a unity project. 


Task 5:

The picture below shows the game without the bloom effect and then the picture below it shows it with the bloom effect. You can see the difference by looking at the shark. These pictures also show the use of a shadow shader.

![image](https://user-images.githubusercontent.com/58942233/228565894-b5d94d58-3796-450d-97dc-2044f15a1a97.png)
![image](https://user-images.githubusercontent.com/58942233/228566039-f4e0e6b5-c254-4d3c-8a80-7bb8f45d4428.png)

The bloom effect was implemented here by using a post-processing profile attached to a child object of the post-processing volume attached to the main camera. The main camera has a post processing layer attached with the same layer as the child object Bloom effect (which has the volume component) and the Bloom Effect placed into the Trigger field. I made it a little different from a previous implementation in our group assignment by increasing the intensity.

The shadow shader was implemented in the following way. It uses standard properties with intensity, line count, shadow color, and 2 texture images. There's 3 pragmas for the vertex shader, fragment shader, and lighting components. The appdata struct will be targeting the vertex position of the object, the normals, and the texture coordinates. The v2f struct references the texture coordinates, diffuse, sv positions, and the shadow coordinates. The vertex shader has standard functions like referencing the texture coordinates, but then it includes the use of the world normal, diffuse lighting, and shadows. The fragment shader is the most important part. It uses the basecolor, shadow effect, and the texture for the shadow in an equation to create the desired effect. I changed it by subtracting the shadow from 3 rather than 1 as well as multiplying the intensity by 2 rather than the 2 not being there at all (that was the state of it in the lab where I first made this shader). Then the next pass will be casting the shadow with it being referenced in the struct then the vertex and fragment shaders. This all creates a horizontal lined shadow.


Task 6:

![image](https://user-images.githubusercontent.com/58942233/228577175-a505b654-b7c0-453b-af18-70ae66a5fc70.png)

The code picture above is about a shader called ColoredShadow. It has the properties of color, base texture, and color of the shadow. The subshader then has a render tag, level of detail of 200, it starts the computer graphics program, defines the CSLambert type of surface shader, declares the property values as sampler2D and fixed4 class types, and then has a struct. The struct is fixated on our uv coordinates of the texture.  

![image](https://user-images.githubusercontent.com/58942233/228578560-8427ef62-a699-4ca3-b4e9-35f2dd1d10bd.png)

The code picture above is about the CSLambert lighting model. It first calculates the diffuse lighting for the object. It then calculates the object's final color. The shadow color is added to the final color. The alpha value gets set for the final color with that color being returned at the end of the model. Then the surface function samples the main texture image with color applied to it. It then sets the alpha and albedo values for the output. The cg program is then ended with a diffuse shader being used as a fallback.

This shader could definitely be used to create a lambert shader of object. 


Task 7: 

The Shader I will be discussing from the 2nd half of the term is the depth of field one. 

![image](https://user-images.githubusercontent.com/58942233/228586052-03b26043-35ed-48ef-900c-8569fecc4db0.png)

The image above shows the start of the deph of field shader. The script has the properties of the main texture, camera's depth texture, circle of confusion calculations, and the texture for the calculations of depth of field. 

![image](https://user-images.githubusercontent.com/58942233/228587279-5a312eab-36e7-4ba8-b51d-94a25b7a9d2f.png)

The image above shows the establishment of important variables like the texel size of the the main texture, then 3 float variables of bokehradius, focusdistance, and focusrange are made. Farsighted is made which is an int variable but not actually used in the script. Then 2 structs of VertexData and Interpolators are made. The former struct the texture position and texture coordinates. The ladder struct has the sv position and texture coordinates. 

![image](https://user-images.githubusercontent.com/58942233/228588469-a5f7d143-e71a-4028-898a-6c410ee63a48.png)

Then the vertex program above takes the vertex data struct and returns the interpolators struct. It uses the UnityObjectToClipPos function to transform the vertex position into clip space, and the sv position and texture coordinate values are set for the interpolator. 

![image](https://user-images.githubusercontent.com/58942233/228589690-74b34cb6-7a74-44df-a859-42d74426bc0e.png)

This pass above is made to use the vertex program and fragment program to get the circle of confusion for all the pixels based on their depth, range, and focus distance. The value circle of confusion value is then clamped and multiplied by the bokehradius. This blurs the image. 

![image](https://user-images.githubusercontent.com/58942233/228591437-5d7c8175-afa9-48b9-bb43-eb5a66e76e6c.png)

The pre-filter pass above also uses the vertex and fragment programs to pre-filter the picture. The fragment one gets the circle of confusion values for all the pixels and in a 2x2 grid. It then returns the min and max values. These 2 values are used to calculate the final circle of confusion for the pixel, which is returned; the color of the pixel is returned too. 

![image](https://user-images.githubusercontent.com/58942233/228592608-022c9fc0-6193-49f8-aa45-0a92ae4390e2.png)
![image](https://user-images.githubusercontent.com/58942233/228592771-32d0c85d-61c6-4651-bf77-a699ea295ec4.png)
![image](https://user-images.githubusercontent.com/58942233/228593037-5e4f6ff3-1b6c-4492-a304-dc049ec088af.png)

The 3 images above show the bokeh pass. This one uses the vertex and fragment shaders to make a kernel shaped like a disk for every pixel on the image. This kernel is then defined by an array of float2 values, and the fragment shader uses the kernel to blur the picture depending on the circle of confusion values calculated in the earlier passes. 

![image](https://user-images.githubusercontent.com/58942233/228595573-608659b5-61f8-45e6-81cf-36c11c513a6b.png)

The postFilterPass above applies the post-processing filter to the blurred image made by the bokeh pass. This removes left over artifacts and noise from the image. Therefore, the depth of field effect is much cleaner. This pass smooths out the image while keeping the edges of the surfaces, It utilizes the spatial kernel size and range kernel size. The former finds how far the filter searches for nearby pixels to smooth, while the range kernel size gets the amount of variation in pixel intensity to be allowed before an edge is considered to be present. 

Pass{//4 combinePass
			CGPROGRAM
				#pragma vertex VertexProgram
				#pragma fragment FragmentProgram

				half4 FragmentProgram(Interpolators i) : SV_Target {
					half4 source = tex2D(_MainTex, i.uv);
					half coc = tex2D(_CoCTex, i.uv).r;
					half4 dof = tex2D(_DoFTex, i.uv);

					// coc is multiplied by _Farsighted to determine which side of the focus distance is in focus
					// What this does is invert the depth map (i.e. where black is white, and white is black)

					half dofStrength = smoothstep(0.1, 1, coc * _FarSighted); 
					half3 color = lerp(
						source.rgb, dof.rgb,
						dofStrength + dof.a - dofStrength * dof.a
					);
					return half4(color, source.a);
					//return coc * _FarSighted;
				}
			ENDCG
		}
	}
}

Then the piece of code above (I couldn't load in the picture of it) is the combine pass. It combines the post-filtered and blury image with the original to make the final amount of depth of the depth of field effect. It blends the blurred and unblurred parts of the image to copy how our eyes see things in a depth of field. To get here, the original image from the first pass is blended with the blurred one. Then the blending operation is usually a simple linear lerp that blends these 2 pictures depending on their weighting factor. This factor is obtained from the distance between the pixel's depth value and focal depth value. Pixels that are closer to the focal depth have more weight in the blending operation, while farther pixels have less weight. The output of this is the final image with the depth of field effect applied in all it's realistic appeal. 

Below is a simple diagram of this shader's process:

![image](https://user-images.githubusercontent.com/58942233/228609098-48c1cddb-773f-4fda-9c8f-72713a10b071.png)


This shader can be used to create a more dramatic effect of where the player should be focusing towards in a particular part of the game like a quick-time event. 
