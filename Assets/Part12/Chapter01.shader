Shader "ShaderStuy/12-01"
{
	Properties
	{
		_BumpMap("NormalMap", 2D) = "bump" {}
		_RimColor ("RimColor", Color) = (1,1,1,1)
		_RimPower ("RimPower", Range(1, 10)) = 3
	}
	SubShader
	{
		Tags{"RenderType" = "Transparent" "Queue" = "Transparent"}

		CGPROGRAM
		#pragma surface surf nolight noambient alpha:fade

		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;

		struct Input
		{
			float2 uv_BumpMap;
			float3 viewDir;
			float3 worldPos;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			//o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			o.Emission = float3(0,1,0);
			float rim = saturate(dot(o.Normal, IN.viewDir));
			rim = pow(1-rim, 3) + pow(frac(IN.worldPos.g * 3 - _Time.y), 30);
			o.Alpha = rim;
		}

		float4 Lightingnolight(SurfaceOutput s, float3 lightDir, float atten)
		{
			return float4(0,0,0,s.Alpha);
		}
		ENDCG
	}
	FallBack "Transparent/Diffuse"
}