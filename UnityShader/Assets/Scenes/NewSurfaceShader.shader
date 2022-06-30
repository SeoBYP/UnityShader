Shader "Custom/NewSurfaceShader"
{
    // �ܺο��� �����͸� ��� ���� ���� �Ǵ� �����Ϳ��� ���� �����ϱ� ���� ����
    // �������� �ڵ�󿡼��� ������ �ƴմϴ�.
    // �̸��� ������ Ÿ���� �´� ������ ��������� ������ ���� ���޵ǰ� �˴ϴ�.
    Properties
    {
        _Color      ("Color",           Color       ) = (1,1,1,1)
        _MainTex    ("Albedo (RGB)",    2D          ) = "white" {}
        _Glossiness ("Smoothness",      Range(0,1)  ) = 0.5
        _Metallic   ("Metallic",        Range(0,1)  ) = 0.0
    }
        // Color = float4, fixed4, half4
            // sampler2D
            // float, half, fixed
    // �ڵ��� ������
    SubShader
    {
        // �켱�� �Ǵ� �⺻ ����
        Tags { "RenderType"="Opaque" }
        LOD 200

        // ����Ƽ�� �ڵ��� ������ ���� �κ��� CG ���̴��� �����Ǿ� �ְ�,
        // �������� ���� �κ��� HLSL ���̴��� �����Ǿ� �ֽ��ϴ�.
        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        // ������ ����
        // ������ ������ ������ ���Ѿ� �Ѵ�.
        // 1) ǥ���� �������ϴ� �Լ��� �̸� 2) ���� ����ó���� �ϴ� �Լ��� �̸� 3) �׸��� ����ó��, 4) ���Ŀ���ó��
        #pragma surface surf Lambert fullforwardshadows


        // ���̴� ����
         // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

      

        // �ȼ��� �����Ҷ� �ʿ��� ������ ��û�ϴ� ����
        struct Input
        {
            float2 uv_MainTex;
        };

        // ������Ƽ�� ����� ������ ���
        half _Glossiness;
        half _Metallic;
        fixed4 _Color;
        sampler2D _MainTex;

        // GPU�� ����Ͽ� ���� ���׸����� ����ϴ� ��ü�� ��� �׸��� �����Դϴ�.
        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        // �ȼ��� ������ŭ ȣ��Ǵ� �Լ��Դϴ�.
        // surface ���̴������� ù��° �Ű������� �ݵ�� Input�̶�� �̸��� ���� ����ü �����̾�� �մϴ�.
        // �ι�° �Ű������� ������ ������ �´� ����ü�� �ԷµǾ�� �մϴ�. 
            //Standard -> SurfaceOutputStandard
            //StandardSpecular -> SurfaceOutputStandardSpecular
            //�� ������ ��Ҷ�� -> SurfaceOutput
        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            // ���� ����� ����
            //o.Albedo = c.rgb;

            // ���� ������� ���� ( ������ ���� ���� ) ����
            o.Emission = c.rgb;

            // ������� : Albedo + Emission

            // Metallic and smoothness come from slider variables
            //o.Metallic = _Metallic;
            //o.Smoothness = _Glossiness;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}