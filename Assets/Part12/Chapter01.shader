Shader "ShaderStuy/12-01"
{
	Properties
	{
		_MainTex("Albedo(RGB)", 2D) = "white" {}
		_BumpMap("NormalMap", 2D) = "bump" {}
		_RimColor ("RimColor", Color) = (1,1,1,1)
		_RimPower ("RimPower", Range(1, 10)) = 3
	}
	SubShader
	{
		Tags{"RenderType" = "Transparent" "Queue" = "Transparent"}

		CGPROGRAM
		#pragma surface surf Lambert noambient alpha:fade

		sampler2D _MainTex;
		sampler2D _BumpMap;
		float4 _RimColor;
		float _RimPower;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float3 viewDir;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			//o.Albedo = c.rgb;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			float rim = dot(o.Normal, IN.viewDir);
			o.Emission = _RimColor.rgb;
			o.Alpha = pow(1-rim,_RimPower);
		}
		ENDCG
	}
	FallBack "Diffuse"
}