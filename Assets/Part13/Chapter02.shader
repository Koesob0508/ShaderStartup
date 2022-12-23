Shader "ShaderStudy/13-02"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white"{}
		_BumpMap("NormalMap", 2D) = "bump"{}
		_SpecCol("Specular Color", Color) = (1,1,1,1)
		_SpecPow("Specular Power", Range(10, 200)) = 100
	}
	SubShader
	{
		Tags{"RenderType" = "Opaque"}
		CGPROGRAM
		#pragma surface surf Test noambient

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _SpecCol;
		float _SpecPow;

		struct Input
		{
			float uv_MainTex;
			float uv_BumpMap;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Alpha = c.a;
		}

		float4 LightingTest(SurfaceOutput s, float3 lightDir, float3 viewDir, float atten)
		{
			float4 final;

			// Lambert Term
			float3 DiffColor;
			float ndotl = saturate(dot(s.Normal, lightDir));
			DiffColor = ndotl * s.Albedo * _LightColor0.rgb * atten;
			
			// Spec Term
			float3 SpecColor;
			float3 H = normalize(lightDir + viewDir);
			float spec = saturate(dot(H,s.Normal));
			spec = pow(spec, _SpecPow);
			SpecColor = spec * _SpecCol.rgb;

			// Final Term
			final.rgb = DiffColor.rgb + SpecColor.rgb;
			final.a = s.Alpha;
			return final;
		}
		ENDCG
	}
	FallBack "Diffuse"
}