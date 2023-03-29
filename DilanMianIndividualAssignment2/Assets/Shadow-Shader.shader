Shader "Custom/Shadow-Shader"
{
    Properties
    {
        _Color("Color", Color) = (1,1,1,1)
        _MainTex("Albedo (RGB)", 2D) = "white" {}
        _ShadowTex("Shadow Texture", 2D) = "white" {}
        _Intensity("Intensity", Range(0,1)) = 0.5
        _LineCount("LineCount", Range(0,100)) = 30
        _ShadowColor("Shadow Color", Color) = (0,0,0,1)
        
    }
        SubShader{

            Pass
            {
                Tags {"LightMode" = "ForwardBase"}

                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma multi_compile_fwdbase nolightmap nodirlightmap nodynlightmap novertexlight
                #include "UnityCG.cginc"
                #include "UnityLightingCommon.cginc"

                #include "Lighting.cginc"
                #include "AutoLight.cginc"
                struct appdata {
                    float4 vertex : POSITION;
                    float3 normal : NORMAL;
                    float4 texcoord : TEXCOORD0;
                };

                struct v2f {
                    float2 uv : TEXCOORD0;
                    fixed4 diff : COLOR0;
                    float4 pos : SV_POSITION;
                    SHADOW_COORDS(1)
                        //SHADOW COORDS
                };

                        v2f vert(appdata v) {
                            v2f o;
                            o.pos = UnityObjectToClipPos(v.vertex);
                            o.uv = v.texcoord;

                            half3 worldNormal = UnityObjectToWorldNormal(v.normal);
                            half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
                            o.diff = nl * _LightColor0;
                            TRANSFER_SHADOW(o);

                            return o;
                        }

                        sampler2D _MainTex;
                        float4 _Color;
                        sampler2D _ShadowTex;
                        float4 _ShadowColor;
                        float _Intensity;
                        float _LineCount;

                        fixed4 frag(v2f i) : SV_Target
                        {
                            fixed4 baseColor = tex2D(_MainTex, i.uv) * _Color;
                        fixed shadow = SHADOW_ATTENUATION(i);
                        //baseColor.rgb *= i.diff;
                        fixed4 shadowTex = tex2D(_ShadowTex, i.uv * _LineCount);
                        fixed4 finalCol = baseColor * shadow + ((shadowTex * baseColor * _Intensity * 2) * (3 - shadow));
                        return finalCol;
                        }
                    ENDCG
            }


                    Pass
                    {
                        Tags {"LightMode" = "ShadowCaster"}

                        CGPROGRAM
                        #pragma vertex vert
                        #pragma fragment frag
                        #pragma multi_compile_shadowcaster
                        #include "UnityCG.cginc"

                        struct appdata {
                            float4 vertex : POSITION;
                            float3 normal : NORMAL;
                            float4 texcoord : TEXCOORD0;
                        };

                        struct v2f {
                            V2F_SHADOW_CASTER;

                        };

                        v2f vert(appdata v) {
                            v2f o;
                            TRANSFER_SHADOW_CASTER_NORMALOFFSET(o)
                            return o;
                        }

                        float4 frag(v2f i) : SV_Target{


                            SHADOW_CASTER_FRAGMENT(i)


                        }
                        ENDCG
                    }
        }
}
