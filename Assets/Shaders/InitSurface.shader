Shader "ShaderStudy/Test/Chapter1/TestShader"
{
	Properties
	{
		_Red("Red", Range(0,1)) = 0
		_Green("Green", Range(0,1)) = 0
		_Blue("Blue", Range(0,1)) = 0
		_BrightDark("Brightness $ Darkness", Range(-1,1)) = 0
	}
		SubShader
		{
			Tags { "RenderType" = "Opaque" }

			// 여기서부터 ENDCG까지 CG라는 쉐이더 언어로 작성된 것
			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows noambient
			// 여기까지 설정 파트

			struct Input
			{
				float4 color : COLOR;
			};
			// struct는 구조체 설정. 엔진으로부터 받아와야할 데이터가 여기 들어갑니다.

			float _Red;
			float _Green;
			float _Blue;
			float _BrightDark;

			// 여기서부터 함수. 색상이나 이미지가 출력되는 부분을 만들 수 있다.
			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark;
				o.Alpha = 1;
			}
			ENDCG
		}
			FallBack "Diffuse"
}
