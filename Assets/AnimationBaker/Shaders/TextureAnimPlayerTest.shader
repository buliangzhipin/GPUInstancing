Shader "Unlit/TextureAnimPlayerTest"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_PosTex("position texture1", 2D) = "black"{}
		_NmlTex("normal texture1", 2D) = "white"{}
		_PosTex2("position texture2", 2D) = "black"{}
		_NmlTex2("normal texture2", 2D) = "white"{}
		_PosTex3("position texture3", 2D) = "black"{}
		_NmlTex3("normal texture3", 2D) = "white"{}
		_DT ("delta time", float) = 0
		_Length ("animation length", Float) = 1
		_Type("type",Int) = 1
		[Toggle(ANIM_LOOP)] _Loop("loop", Float) = 0
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100 Cull Off

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#pragma multi_compile ___ ANIM_LOOP

			#include "UnityCG.cginc"

			#define ts _PosTex_TexelSize

			struct appdata
			{
				float2 uv : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID	
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float3 normal : TEXCOORD1;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex, _PosTex, _NmlTex, _PosTex2, _NmlTex2, _PosTex3, _NmlTex3;
			float4 _PosTex_TexelSize;
			float _Length, _DT;
			UNITY_INSTANCING_BUFFER_START(Props)
                UNITY_DEFINE_INSTANCED_PROP(int, _Type)
            UNITY_INSTANCING_BUFFER_END(Props)
			
			v2f vert (appdata v, uint vid : SV_VertexID)
			{
				UNITY_SETUP_INSTANCE_ID(v);
				float t = (_Time.y - _DT) / _Length;
#if ANIM_LOOP
				t = fmod(t, 1.0);
#else
				t = saturate(t);
#endif
				float x = (vid + 0.5) * ts.x;
				float y = t;
				float4 pos;
				float3 normal;
				int type = UNITY_ACCESS_INSTANCED_PROP(Props, _Type);
				if(type == 1)
				{				
					pos = tex2Dlod(_PosTex, float4(x, y, 0, 0));
					normal = tex2Dlod(_NmlTex, float4(x, y, 0, 0));
				}else if(type == 2)
				{
					pos = tex2Dlod(_PosTex2, float4(x, y, 0, 0));
					normal = tex2Dlod(_NmlTex2, float4(x, y, 0, 0));
				}else if(type == 3)
				{
					pos = tex2Dlod(_PosTex3, float4(x, y, 0, 0));
					normal = tex2Dlod(_NmlTex3, float4(x, y, 0, 0));
				}


				v2f o;
				o.vertex = UnityObjectToClipPos(pos);
				o.normal = UnityObjectToWorldNormal(normal);
				o.uv = v.uv;
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{
				half diff = dot(i.normal, float3(0,1,0))*0.5 + 0.5;
				half4 col = tex2D(_MainTex, i.uv);
				return diff * col;
			}
			ENDCG
		}
	}
}
