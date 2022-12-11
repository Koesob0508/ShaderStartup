Shader "ShaderStudy/06-06"
{
	Properties
	{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_MainTex2("Albedo (RGB)", 2D) = "black" {}
		_Intense("Intense float", Range(0,10)) = 1
	}

	SubShader
	{
		Tags { "RenderType" = "Transparent" "Queue" = "Transparent"}
		Lod 200

		CGPROGRAM
		#pragma surface surf Standard alpha:fade

		sampler2D _MainTex;
		sampler2D _MainTex2;
		float _Intense;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_MainTex2;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed e = _Intense;
			fixed4 d = tex2D(_MainTex2, float2(IN.uv_MainTex2.x, IN.uv_MainTex2.y - _Time.y));
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex + d.r * e);
			
			o.Emission = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}