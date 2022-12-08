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

			// ���⼭���� ENDCG���� CG��� ���̴� ���� �ۼ��� ��
			CGPROGRAM
			#pragma surface surf Standard fullforwardshadows noambient
			// ������� ���� ��Ʈ

			struct Input
			{
				float4 color : COLOR;
			};
			// struct�� ����ü ����. �������κ��� �޾ƿ;��� �����Ͱ� ���� ���ϴ�.

			float _Red;
			float _Green;
			float _Blue;
			float _BrightDark;

			// ���⼭���� �Լ�. �����̳� �̹����� ��µǴ� �κ��� ���� �� �ִ�.
			void surf(Input IN, inout SurfaceOutputStandard o)
			{
				o.Albedo = float3(_Red, _Green, _Blue) + _BrightDark;
				o.Alpha = 1;
			}
			ENDCG
		}
			FallBack "Diffuse"
}
