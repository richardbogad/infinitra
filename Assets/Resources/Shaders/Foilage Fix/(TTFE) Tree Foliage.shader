// Made with Amplify Shader Editor v1.9.3.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Toby Fredson/The Toby Foliage Engine/(TTFE) Tree Foliage"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[Header(__________(TTFE) TREE FOLIAGE SHADER___________)][Header(_____________________________________________________)][Header(Texture Maps)][NoScaleOffset]_AlbedoMap("Albedo Map", 2D) = "white" {}
		[NoScaleOffset][Normal]_NormalMap("Normal Map", 2D) = "bump" {}
		[NoScaleOffset]_MaskMapRGBA("Mask Map *RGB(A)", 2D) = "white" {}
		[NoScaleOffset]_NoiseMapGrayscale("Noise Map (Grayscale)", 2D) = "white" {}
		[Header(_____________________________________________________)][Header(Texture settings)][Header((Albedo))]_AlbedoColor("Albedo Color", Color) = (1,1,1,0)
		[Header((Normal))]_NormalIntenisty("Normal Intenisty", Float) = 1
		[Toggle]_NormalBackFaceFixBranch("Normal Back Face Fix (Branch)", Float) = 0
		[Header((Smoothness))]_SmoothnessIntensity("Smoothness Intensity", Range( 0 , 1)) = 1
		[Header((Ambient Occlusion))]_AmbientOcclusionIntensity("Ambient Occlusion Intensity", Range( 0 , 1)) = 1
		[Header((Translucency))]_TranslucencyPower("Translucency Power", Range( 1 , 10)) = 1
		_TranslucencyRange("Translucency Range", Float) = 1
		[Toggle]_TranslucencyTreeTangents("Translucency Tree Tangents", Float) = 0
		[Header( _____________________________________________________)][Header(Shading Settings)][Header((Self Shading))]_VertexLighting("Vertex Lighting", Float) = 0
		_VertexShadow("Vertex Shadow", Float) = 0
		[Toggle(_SELFSHADINGVERTEXCOLOR_ON)] _SelfShadingVertexColor("Self Shading (Vertex Color)", Float) = 0
		[Toggle(_MOBILESHADINGWORLDUP_ON)] _MobileShadingWorldUp("Mobile Shading (World Up)", Float) = 0
		[Header(Season Settings)][Header((Season Control))]_ColorVariation("Color Variation", Range( 0 , 1)) = 1
		_DryLeafColor("Dry Leaf Color", Color) = (0.5568628,0.3730685,0.1764706,0)
		_DryLeavesScale("Dry Leaves - Scale", Float) = 0
		_DryLeavesOffset("Dry Leaves - Offset", Float) = 0
		_SeasonChangeGlobal("Season Change - Global", Range( -2 , 2)) = 0
		[Toggle]_BranchMaskR("Branch Mask *(R)", Float) = 0
		[Toggle]_NormalizeSeasons("Normalize Seasons", Float) = 0
		[Toggle]_BakedGIONOFF("Baked GI ON/OFF", Float) = 0
		[Header(_____________________________________________________)][Header(Wind Settings)][Header((Global Wind Settings))]_GlobalWindStrength("Global Wind Strength", Range( 0 , 1)) = 1
		_StrongWindSpeed("Strong Wind Speed", Range( 1 , 3)) = 1
		[KeywordEnum(GentleBreeze,WindOff)] _WindType("Wind Type", Float) = 0
		[Header((Trunk and Branch))]_BranchWindLarge("Branch Wind Large", Range( 0 , 20)) = 1
		_BranchWindSmall("Branch Wind Small", Range( 0 , 20)) = 1
		[Toggle(_LEAFFLUTTER_ON)] _LeafFlutter("Leaf Flutter", Float) = 1
		_GlobalFlutterIntensity("Global Flutter Intensity", Range( 0 , 20)) = 1
		[NoScaleOffset]_WindNoise("Wind Noise Map", 2D) = "white" {}
		[Toggle]_PivotSway("Pivot Sway", Float) = 0
		[Header((Wind Mask))]_Radius("Radius", Float) = 1
		_Hardness("Hardness", Float) = 1
		[Toggle]_CenterofMass("Center of Mass", Float) = 0
		[Toggle]_SwitchVGreenToRGBA("Switch VGreen To RGBA", Float) = 0
		
		[DiffusionProfile]_DiffusionProfile("Diffusion Profile", Float) = 3.4622349739074707[HideInInspector]_DiffusionProfile_Asset("Diffusion Profile", Vector) = ( -0.000000000000000000014871875386329483, -0.00000000000000000000000000000000000507447616626983, -0.0000000000038101292954006993, 71724591347873995000000000000 )
		[HideInInspector] _texcoord( "", 2D ) = "white" {}

		[HideInInspector] _RenderQueueType("Render Queue Type", Float) = 1
		//[HideInInspector][ToggleUI] _AddPrecomputedVelocity("Add Precomputed Velocity", Float) = 1
		[HideInInspector][ToggleUI] _SupportDecals("Support Decals", Float) = 1.0
		[HideInInspector] _StencilRef("Stencil Ref", Int) = 0 // StencilUsage.Clear
		[HideInInspector] _StencilWriteMask("Stencil Write Mask", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefDepth("Stencil Ref Depth", Int) = 0 // Nothing
		[HideInInspector] _StencilWriteMaskDepth("Stencil Write Mask Depth", Int) = 8 // StencilUsage.TraceReflectionRay
		[HideInInspector] _StencilRefMV("Stencil Ref MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilWriteMaskMV("Stencil Write Mask MV", Int) = 32 // StencilUsage.ObjectMotionVector
		[HideInInspector] _StencilRefDistortionVec("Stencil Ref Distortion Vec", Int) = 4 				// DEPRECATED
		[HideInInspector] _StencilWriteMaskDistortionVec("Stencil Write Mask Distortion Vec", Int) = 4	// DEPRECATED
		[HideInInspector] _StencilWriteMaskGBuffer("Stencil Write Mask GBuffer", Int) = 3 // StencilUsage.RequiresDeferredLighting | StencilUsage.SubsurfaceScattering
		[HideInInspector] _StencilRefGBuffer("Stencil Ref GBuffer", Int) = 2 // StencilUsage.RequiresDeferredLighting
		[HideInInspector] _ZTestGBuffer("ZTest GBuffer", Int) = 4
		[HideInInspector][ToggleUI] _RequireSplitLighting("Require Split Lighting", Float) = 0
		[HideInInspector][ToggleUI] _ReceivesSSR("Receives SSR", Float) = 1
		[HideInInspector][ToggleUI] _ReceivesSSRTransparent("Receives SSR Transparent", Float) = 0
		[HideInInspector] _SurfaceType("Surface Type", Float) = 0
		[HideInInspector] _BlendMode("Blend Mode", Float) = 0
		[HideInInspector] _SrcBlend("Src Blend", Float) = 1
		[HideInInspector] _DstBlend("Dst Blend", Float) = 0
		[HideInInspector] _AlphaSrcBlend("Alpha Src Blend", Float) = 1
		[HideInInspector] _AlphaDstBlend("Alpha Dst Blend", Float) = 0
		[HideInInspector][ToggleUI] _ZWrite("ZWrite", Float) = 1
		[HideInInspector][ToggleUI] _TransparentZWrite("Transparent ZWrite", Float) = 0
		[HideInInspector] _CullMode("Cull Mode", Float) = 2
		[HideInInspector] _TransparentSortPriority("Transparent Sort Priority", Float) = 0
		[HideInInspector][ToggleUI] _EnableFogOnTransparent("Enable Fog", Float) = 1
		[HideInInspector] _CullModeForward("Cull Mode Forward", Float) = 2 // This mode is dedicated to Forward to correctly handle backface then front face rendering thin transparent
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.TransparentCullMode)] _TransparentCullMode("Transparent Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector] _ZTestDepthEqualForOpaque("ZTest Depth Equal For Opaque", Int) = 4 // Less equal
		[HideInInspector][Enum(UnityEngine.Rendering.CompareFunction)] _ZTestTransparent("ZTest Transparent", Int) = 4 // Less equal
		[HideInInspector][ToggleUI] _TransparentBackfaceEnable("Transparent Backface Enable", Float) = 0
		[HideInInspector][ToggleUI] _AlphaCutoffEnable("Alpha Cutoff Enable", Float) = 0
		[HideInInspector][ToggleUI] _UseShadowThreshold("Use Shadow Threshold", Float) = 0
		[HideInInspector][ToggleUI] _DoubleSidedEnable("Double Sided Enable", Float) = 1
		[HideInInspector][Enum(Flip, 0, Mirror, 1, None, 2)] _DoubleSidedNormalMode("Double Sided Normal Mode", Float) = 2
		[HideInInspector] _DoubleSidedConstants("DoubleSidedConstants", Vector) = (1,1,-1,0)

		//_TessPhongStrength( "Tess Phong Strength", Range( 0, 1 ) ) = 0.5
		//_TessValue( "Tess Max Tessellation", Range( 1, 32 ) ) = 16
		//_TessMin( "Tess Min Distance", Float ) = 10
		//_TessMax( "Tess Max Distance", Float ) = 25
		//_TessEdgeLength ( "Tess Edge length", Range( 2, 50 ) ) = 16
		//_TessMaxDisp( "Tess Max Displacement", Float ) = 25

		[HideInInspector][ToggleUI] _TransparentWritingMotionVec("Transparent Writing MotionVec", Float) = 0
		[HideInInspector][Enum(UnityEditor.Rendering.HighDefinition.OpaqueCullMode)] _OpaqueCullMode("Opaque Cull Mode", Int) = 2 // Back culling by default
		[HideInInspector][ToggleUI] _EnableBlendModePreserveSpecularLighting("Enable Blend Mode Preserve Specular Lighting", Float) = 1
		[HideInInspector] _EmissionColor("Color", Color) = (1, 1, 1)

		[HideInInspector][NoScaleOffset] unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset] unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}

		[HideInInspector][Enum(Auto, 0, On, 1, Off, 2)] _DoubleSidedGIMode("Double sided GI mode", Float) = 0

		[HideInInspector][ToggleUI] _AlphaToMaskInspectorValue("_AlphaToMaskInspectorValue", Float) = 0 // Property used to save the alpha to mask state in the inspector
        [HideInInspector][ToggleUI] _AlphaToMask("__alphaToMask", Float) = 0

		//_Refrac ( "Refraction Model", Float) = 0
        [HideInInspector][ToggleUI]_DepthOffsetEnable("Boolean", Float) = 1
        [HideInInspector][ToggleUI]_ConservativeDepthOffsetEnable("Boolean", Float) = 1
	}

	SubShader
	{
		LOD 0

		

		Tags { "RenderPipeline"="HDRenderPipeline" "RenderType"="Opaque" "Queue"="Geometry" }

		HLSLINCLUDE
		#pragma target 4.5
		#pragma exclude_renderers glcore gles gles3 ps4 ps5 

		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
		#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Filtering.hlsl"

		struct GlobalSurfaceDescription // GBuffer Forward META TransparentBackface
		{
			float3 BaseColor;
			float3 Normal;
			float3 BentNormal;
			float3 Specular;
			float CoatMask;
			float Metallic;
			float3 Emission;
			float Smoothness;
			float Occlusion;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float AlphaClipThresholdDepthPostpass;
			float SpecularOcclusion;
			float SpecularAAScreenSpaceVariance;
			float SpecularAAThreshold;
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			float DiffusionProfile;
			float TransmissionMask;
			float Thickness;
			float SubsurfaceMask;
			float Anisotropy;
			float3 Tangent;
			float IridescenceMask;
			float IridescenceThickness;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct AlphaSurfaceDescription // ShadowCaster
		{
			float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct SceneSurfaceDescription // SceneSelection
		{
		    float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float RefractionIndex;
			float3 RefractionColor;
			float RefractionDistance;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct PrePassSurfaceDescription // DepthPrePass
		{
			float3 Normal;
			float3 Emission;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPrepass;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct PostPassSurfaceDescription //DepthPostPass
		{
			float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float AlphaClipThresholdDepthPostpass;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

		struct SmoothSurfaceDescription // MotionVectors DepthOnly
		{
			float3 Normal;
			float3 Emission;
			float Smoothness;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;
		};

        struct PickingSurfaceDescription //Picking
		{
            float3 BentNormal;
			float3 Emission;
			float Alpha;
			float AlphaClipThreshold;
			float AlphaClipThresholdShadow;
			float3 BakedGI;
			float3 BakedBackGI;
			float DepthOffset;
			float4 VTPackedFeedback;

			float3 ObjectSpaceNormal;
			float3 WorldSpaceNormal;
			float3 TangentSpaceNormal;
			float3 ObjectSpaceViewDirection;
			float3 WorldSpaceViewDirection;
			float3 ObjectSpacePosition;
		};

		#ifndef ASE_TESS_FUNCS
		#define ASE_TESS_FUNCS
		float4 FixedTess( float tessValue )
		{
			return tessValue;
		}

		float CalcDistanceTessFactor (float4 vertex, float minDist, float maxDist, float tess, float4x4 o2w, float3 cameraPos )
		{
			float3 wpos = mul(o2w,vertex).xyz;
			float dist = distance (wpos, cameraPos);
			float f = clamp(1.0 - (dist - minDist) / (maxDist - minDist), 0.01, 1.0) * tess;
			return f;
		}

		float4 CalcTriEdgeTessFactors (float3 triVertexFactors)
		{
			float4 tess;
			tess.x = 0.5 * (triVertexFactors.y + triVertexFactors.z);
			tess.y = 0.5 * (triVertexFactors.x + triVertexFactors.z);
			tess.z = 0.5 * (triVertexFactors.x + triVertexFactors.y);
			tess.w = (triVertexFactors.x + triVertexFactors.y + triVertexFactors.z) / 3.0f;
			return tess;
		}

		float CalcEdgeTessFactor (float3 wpos0, float3 wpos1, float edgeLen, float3 cameraPos, float4 scParams )
		{
			float dist = distance (0.5 * (wpos0+wpos1), cameraPos);
			float len = distance(wpos0, wpos1);
			float f = max(len * scParams.y / (edgeLen * dist), 1.0);
			return f;
		}

		float DistanceFromPlaneASE (float3 pos, float4 plane)
		{
			return dot (float4(pos,1.0f), plane);
		}

		bool WorldViewFrustumCull (float3 wpos0, float3 wpos1, float3 wpos2, float cullEps, float4 planes[6] )
		{
			float4 planeTest;
			planeTest.x = (( DistanceFromPlaneASE(wpos0, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[0]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[0]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.y = (( DistanceFromPlaneASE(wpos0, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[1]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[1]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.z = (( DistanceFromPlaneASE(wpos0, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[2]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[2]) > -cullEps) ? 1.0f : 0.0f );
			planeTest.w = (( DistanceFromPlaneASE(wpos0, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos1, planes[3]) > -cullEps) ? 1.0f : 0.0f ) +
						  (( DistanceFromPlaneASE(wpos2, planes[3]) > -cullEps) ? 1.0f : 0.0f );
			return !all (planeTest);
		}

		float4 DistanceBasedTess( float4 v0, float4 v1, float4 v2, float tess, float minDist, float maxDist, float4x4 o2w, float3 cameraPos )
		{
			float3 f;
			f.x = CalcDistanceTessFactor (v0,minDist,maxDist,tess,o2w,cameraPos);
			f.y = CalcDistanceTessFactor (v1,minDist,maxDist,tess,o2w,cameraPos);
			f.z = CalcDistanceTessFactor (v2,minDist,maxDist,tess,o2w,cameraPos);

			return CalcTriEdgeTessFactors (f);
		}

		float4 EdgeLengthBasedTess( float4 v0, float4 v1, float4 v2, float edgeLength, float4x4 o2w, float3 cameraPos, float4 scParams )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;
			tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
			tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
			tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
			tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			return tess;
		}

		float4 EdgeLengthBasedTessCull( float4 v0, float4 v1, float4 v2, float edgeLength, float maxDisplacement, float4x4 o2w, float3 cameraPos, float4 scParams, float4 planes[6] )
		{
			float3 pos0 = mul(o2w,v0).xyz;
			float3 pos1 = mul(o2w,v1).xyz;
			float3 pos2 = mul(o2w,v2).xyz;
			float4 tess;

			if (WorldViewFrustumCull(pos0, pos1, pos2, maxDisplacement, planes))
			{
				tess = 0.0f;
			}
			else
			{
				tess.x = CalcEdgeTessFactor (pos1, pos2, edgeLength, cameraPos, scParams);
				tess.y = CalcEdgeTessFactor (pos2, pos0, edgeLength, cameraPos, scParams);
				tess.z = CalcEdgeTessFactor (pos0, pos1, edgeLength, cameraPos, scParams);
				tess.w = (tess.x + tess.y + tess.z) / 3.0f;
			}
			return tess;
		}
		#endif //ASE_TESS_FUNCS
		ENDHLSL

		
		Pass
		{
			
			Name "GBuffer"
			Tags { "LightMode"="GBuffer" }

			Cull [_CullMode]
			ZTest [_ZTestGBuffer]

			Stencil
			{
				Ref [_StencilRefGBuffer]
				WriteMask [_StencilWriteMaskGBuffer]
				Comp Always
				Pass Replace
			}


			ColorMask [_LightLayersMaskBuffer4] 4
			ColorMask [_LightLayersMaskBuffer5] 5

			HLSLPROGRAM
            #define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
            #define _SPECULAR_OCCLUSION_FROM_AO 1
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #define ASE_NEED_CULLFACE 1
            #pragma shader_feature_local _ _DOUBLESIDED_ON
            #pragma shader_feature_local _ _ALPHATEST_ON
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #define _MATERIAL_FEATURE_TRANSMISSION 1
            #define _AMBIENT_OCCLUSION 1
            #define ASE_BAKEDGI 1
            #define ASE_BAKEDBACKGI 1
            #define HAVE_MESH_MODIFICATION
            #define ASE_SRP_VERSION 140008
            #if !defined(ASE_NEED_CULLFACE)
            #define ASE_NEED_CULLFACE 1
            #endif //ASE_NEED_CULLFACE

            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma multi_compile_fragment _ LIGHT_LAYERS
            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile_fragment PROBE_VOLUMES_OFF PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
            #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_GBUFFER

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _AlbedoMap;
			sampler2D _NoiseMapGrayscale;
			sampler2D _MaskMapRGBA;
			sampler2D _NormalMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_POSITION
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_VFACE
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON
			#pragma shader_feature_local _SELFSHADINGVERTEXCOLOR_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};


			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			
			
			float4 SampleGradient( Gradient gradient, float time )
			{
				float3 color = gradient.colors[0].rgb;
				UNITY_UNROLL
				for (int c = 1; c < 8; c++)
				{
				float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, gradient.colorsLength-1));
				color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
				}
				#ifndef UNITY_COLORSPACE_GAMMA
				color = SRGBToLinear(color);
				#endif
				float alpha = gradient.alphas[0].x;
				UNITY_UNROLL
				for (int a = 1; a < 8; a++)
				{
				float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, gradient.alphasLength-1));
				alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
				}
				return float4(color, alpha);
			}
			
			float3 ASEBakedGI( float3 positionWS, float3 normalWS,  uint2 positionSS, float2 uvStaticLightmap, float2 uvDynamicLightmap )
			{
				float3 positionRWS = GetCameraRelativePositionWS( positionWS );
				return SampleBakedGI( positionRWS, normalWS, positionSS, uvStaticLightmap, uvDynamicLightmap );
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness =					surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
                    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;
	
	            
				#if ( ASE_SRP_VERSION >= 100000 ) && ( ASE_SRP_VERSION <= 140008 )
				GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

				#if HAVE_DECALS
				if (_EnableDecals)
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif
				#endif
               

	            

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
				    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				    {
					   surfaceData.metallic = 0;
				    }
				    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData); 
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif  
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.ase_texcoord.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord5.xy = inputMesh.ase_texcoord.xy;
				outputPackedVaryingsMeshToPS.ase_texcoord6 = float4(inputMesh.positionOS,1);
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord5.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput,
						OUTPUT_GBUFFER(outGBuffer)
						#ifdef _DEPTHOFFSET_ON
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
						)
			{

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.uv1.xyzw;
				input.texCoord2 = packedInput.uv2.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);
				SurfaceData surfaceData;
				BuiltinData builtinData;

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float2 uv_AlbedoMap513_g1583 = packedInput.ase_texcoord5.xy;
				float2 uv_AlbedoMap662_g1583 = packedInput.ase_texcoord5.xy;
				float4 tex2DNode662_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap662_g1583 );
				float2 uv_NoiseMapGrayscale669_g1583 = packedInput.ase_texcoord5.xy;
				float4 transform741_g1583 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
				transform741_g1583.xyz = GetAbsolutePositionWS((transform741_g1583).xyz);
				float dotResult4_g1585 = dot( transform741_g1583.xy , float2( 12.9898,78.233 ) );
				float lerpResult10_g1585 = lerp( 0.0 , 1.0 , frac( ( sin( dotResult4_g1585 ) * 43758.55 ) ));
				float temp_output_742_0_g1583 = lerpResult10_g1585;
				float normalizeResult811_g1583 = normalize( temp_output_742_0_g1583 );
				float3 normalizeResult439_g1583 = normalize( packedInput.ase_texcoord6.xyz );
				float DryLeafPositionMask443_g1583 = ( (distance( normalizeResult439_g1583 , float3( 0,0.8,0 ) )*1.0 + 0.0) * 1 );
				float4 lerpResult677_g1583 = lerp( ( _DryLeafColor * ( tex2DNode662_g1583.g * 2 ) ) , tex2DNode662_g1583 , saturate( (( ( tex2D( _NoiseMapGrayscale, uv_NoiseMapGrayscale669_g1583 ).r * (( _NormalizeSeasons )?( normalizeResult811_g1583 ):( temp_output_742_0_g1583 )) * DryLeafPositionMask443_g1583 ) - _SeasonChangeGlobal )*_DryLeavesScale + _DryLeavesOffset) ));
				float4 SeasonControl_Output676_g1583 = lerpResult677_g1583;
				Gradient gradient752_g1583 = NewGradient( 0, 2, 2, float4( 1, 0.276868, 0, 0 ), float4( 0, 1, 0.7818019, 1 ), 0, 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
				float4 transform754_g1583 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
				transform754_g1583.xyz = GetAbsolutePositionWS((transform754_g1583).xyz);
				float dotResult4_g1584 = dot( transform754_g1583.xy , float2( 12.9898,78.233 ) );
				float lerpResult10_g1584 = lerp( 0.0 , 1.0 , frac( ( sin( dotResult4_g1584 ) * 43758.55 ) ));
				float4 lerpResult515_g1583 = lerp( SeasonControl_Output676_g1583 , ( ( SeasonControl_Output676_g1583 * 0.5 ) + ( SampleGradient( gradient752_g1583, lerpResult10_g1584 ) * SeasonControl_Output676_g1583 ) ) , _ColorVariation);
				float2 uv_MaskMapRGBA505_g1583 = packedInput.ase_texcoord5.xy;
				float4 lerpResult521_g1583 = lerp( tex2D( _AlbedoMap, uv_AlbedoMap513_g1583 ) , lerpResult515_g1583 , (( _BranchMaskR )?( tex2D( _MaskMapRGBA, uv_MaskMapRGBA505_g1583 ).r ):( 1.0 )));
				float3 temp_output_465_0_g1583 = ( ( packedInput.ase_texcoord6.xyz * float3( 2,1.3,2 ) ) / 25.0 );
				float dotResult471_g1583 = dot( temp_output_465_0_g1583 , temp_output_465_0_g1583 );
				float3 normalizeResult457_g1583 = normalize( packedInput.ase_texcoord6.xyz );
				float SelfShading601_g1583 = saturate( (( pow( abs( saturate( dotResult471_g1583 ) ) , 1.5 ) + ( ( 1.0 - (distance( normalizeResult457_g1583 , float3( 0,0.8,0 ) )*0.5 + 0.0) ) * 0.6 ) )*0.92 + -0.16) );
				#ifdef _SELFSHADINGVERTEXCOLOR_ON
				float4 staticSwitch618_g1583 = ( lerpResult521_g1583 * (SelfShading601_g1583*_VertexLighting + _VertexShadow) );
				#else
				float4 staticSwitch618_g1583 = lerpResult521_g1583;
				#endif
				float4 GrassColorVariation_Output586_g1583 = staticSwitch618_g1583;
				float4 transform487_g1583 = mul(GetObjectToWorldMatrix(),float4( packedInput.ase_texcoord6.xyz , 0.0 ));
				transform487_g1583.xyz = GetAbsolutePositionWS((transform487_g1583).xyz);
				float dotResult566_g1583 = dot( float4( V , 0.0 ) , -( float4( -_DirectionalLightDatas[0].forward , 0.0 ) + ( (( _TranslucencyTreeTangents )?( float4( packedInput.ase_normal , 0.0 ) ):( transform487_g1583 )) * _TranslucencyRange ) ) );
				float2 uv_MaskMapRGBA516_g1583 = packedInput.ase_texcoord5.xy;
				float ase_lightIntensity = max( max( _DirectionalLightDatas[0].color.r, _DirectionalLightDatas[0].color.g ), _DirectionalLightDatas[0].color.b );
				float4 ase_lightColor = float4( _DirectionalLightDatas[0].color.rgb / ase_lightIntensity, ase_lightIntensity );
				float TobyTranslucency526_g1583 = ( saturate( dotResult566_g1583 ) * tex2D( _MaskMapRGBA, uv_MaskMapRGBA516_g1583 ).b * ase_lightColor.a );
				float TranslucencyIntensity616_g1583 = _TranslucencyPower;
				float4 Albedo_Output613_g1583 = ( ( _AlbedoColor * GrassColorVariation_Output586_g1583 ) * (1.0 + (TobyTranslucency526_g1583 - 0.0) * (TranslucencyIntensity616_g1583 - 1.0) / (1.0 - 0.0)) );
				
				float2 uv_NormalMap531_g1583 = packedInput.ase_texcoord5.xy;
				float3 unpack531_g1583 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap531_g1583 ), _NormalIntenisty );
				unpack531_g1583.z = lerp( 1, unpack531_g1583.z, saturate(_NormalIntenisty) );
				float3 tex2DNode531_g1583 = unpack531_g1583;
				float3 break539_g1583 = tex2DNode531_g1583;
				float3 appendResult552_g1583 = (float3(break539_g1583.x , break539_g1583.y , ( break539_g1583.z * isFrontFace )));
				float3 Normal_Output557_g1583 = (( _NormalBackFaceFixBranch )?( appendResult552_g1583 ):( tex2DNode531_g1583 ));
				
				float2 uv_MaskMapRGBA535_g1583 = packedInput.ase_texcoord5.xy;
				float4 tex2DNode535_g1583 = tex2D( _MaskMapRGBA, uv_MaskMapRGBA535_g1583 );
				float Smoothness_Output558_g1583 = ( tex2DNode535_g1583.a * _SmoothnessIntensity );
				
				float AoMapBase538_g1583 = tex2DNode535_g1583.g;
				float AmbientOcclusion_Output582_g1583 = pow( abs( AoMapBase538_g1583 ) , _AmbientOcclusionIntensity );
				
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord5.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				float translucency792_g1583 = saturate( ( 1.0 - tex2DNode535_g1583.b ) );
				float Translucency_Output818_g1583 = translucency792_g1583;
				
				float3 bakedGI2874 = ASEBakedGI( float3( 0,0,0 ), float3( 0,0,0 ), int2( 0,0 ), float2( 0,0 ), float2( 0,0 ) );
				float3 temp_output_2873_0 = ( float3( 0,0,0 ) * bakedGI2874 );
				
				surfaceDescription.BaseColor = Albedo_Output613_g1583.rgb;
				surfaceDescription.Normal = Normal_Output557_g1583;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = 0;
				surfaceDescription.Smoothness = Smoothness_Output558_g1583;
				surfaceDescription.Occlusion = AmbientOcclusion_Output582_g1583;
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				surfaceDescription.AlphaClipThresholdDepthPrepass = 0.5;
				surfaceDescription.AlphaClipThresholdDepthPostpass = 0.5;

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = Translucency_Output818_g1583;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = _DiffusionProfile;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = (( _BakedGIONOFF )?( temp_output_2873_0 ):( float3( 0,0,0 ) ));
				#endif
				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = temp_output_2873_0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				GetSurfaceAndBuiltinData( surfaceDescription, input, V, posInput, surfaceData, builtinData );
				ENCODE_INTO_GBUFFER( surfaceData, builtinData, posInput.positionSS, outGBuffer );
				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "META"
			Tags { "LightMode"="Meta" }

			Cull Off

			HLSLPROGRAM
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_NEED_CULLFACE 1
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#pragma shader_feature_local _ _ALPHATEST_ON
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define _MATERIAL_FEATURE_TRANSMISSION 1
			#define _AMBIENT_OCCLUSION 1
			#define ASE_BAKEDGI 1
			#define ASE_BAKEDBACKGI 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140008
			#if !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif //ASE_NEED_CULLFACE

			#pragma shader_feature _ EDITOR_VISUALIZATION
			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

            #define SHADERPASS SHADERPASS_LIGHT_TRANSPORT
            #define SCENEPICKINGPASS 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _AlbedoMap;
			sampler2D _NoiseMapGrayscale;
			sampler2D _MaskMapRGBA;
			sampler2D _NormalMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#if SHADERPASS == SHADERPASS_LIGHT_TRANSPORT
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#endif

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/MetaPass.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_POSITION
			#define ASE_NEEDS_FRAG_VFACE
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON
			#pragma shader_feature_local _SELFSHADINGVERTEXCOLOR_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				#ifdef EDITOR_VISUALIZATION
				float2 VizUV : TEXCOORD0;
				float4 LightCoord : TEXCOORD1;
				#endif
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			
			
			float4 SampleGradient( Gradient gradient, float time )
			{
				float3 color = gradient.colors[0].rgb;
				UNITY_UNROLL
				for (int c = 1; c < 8; c++)
				{
				float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, gradient.colorsLength-1));
				color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
				}
				#ifndef UNITY_COLORSPACE_GAMMA
				color = SRGBToLinear(color);
				#endif
				float alpha = gradient.alphas[0].x;
				UNITY_UNROLL
				for (int a = 1; a < 8; a++)
				{
				float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, gradient.alphasLength-1));
				alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
				}
				return float4(color, alpha);
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =					surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

                #ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

                #ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
                #endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;

	            
                #if ASE_SRP_VERSION <=140008
				GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

				#if HAVE_DECALS
				if (_EnableDecals)
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif
                #endif
               

	            

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
				    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				    {
					   surfaceData.metallic = 0;
				    }
				    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData); 
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh  )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);

				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.uv0.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord4.xyz = ase_worldPos;
				
				outputPackedVaryingsMeshToPS.ase_texcoord2.xy = inputMesh.uv0.xy;
				outputPackedVaryingsMeshToPS.ase_texcoord3 = float4(inputMesh.positionOS,1);
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord2.zw = 0;
				outputPackedVaryingsMeshToPS.ase_texcoord4.w = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				outputPackedVaryingsMeshToPS.positionCS = UnityMetaVertexPosition(inputMesh.positionOS, inputMesh.uv1.xy, inputMesh.uv2.xy, unity_LightmapST, unity_DynamicLightmapST);

				#ifdef EDITOR_VISUALIZATION
					float2 vizUV = 0;
					float4 lightCoord = 0;
					UnityEditorVizData(inputMesh.positionOS.xyz, inputMesh.uv0.xy, inputMesh.uv1.xy, inputMesh.uv2.xy, vizUV, lightCoord);

					outputPackedVaryingsMeshToPS.VizUV.xy = vizUV;
					outputPackedVaryingsMeshToPS.LightCoord = lightCoord;
				#endif

				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv0 = v.uv0;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.uv3 = v.uv3;
				o.ase_color = v.ase_color;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv0 = patch[0].uv0 * bary.x + patch[1].uv0 * bary.y + patch[2].uv0 * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.uv3 = patch[0].uv3 * bary.x + patch[1].uv3 * bary.y + patch[2].uv3 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			float4 Frag(PackedVaryingsMeshToPS packedInput  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( packedInput );
				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);
				float3 V = float3(1.0, 1.0, 1.0);

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float2 uv_AlbedoMap513_g1583 = packedInput.ase_texcoord2.xy;
				float2 uv_AlbedoMap662_g1583 = packedInput.ase_texcoord2.xy;
				float4 tex2DNode662_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap662_g1583 );
				float2 uv_NoiseMapGrayscale669_g1583 = packedInput.ase_texcoord2.xy;
				float4 transform741_g1583 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
				transform741_g1583.xyz = GetAbsolutePositionWS((transform741_g1583).xyz);
				float dotResult4_g1585 = dot( transform741_g1583.xy , float2( 12.9898,78.233 ) );
				float lerpResult10_g1585 = lerp( 0.0 , 1.0 , frac( ( sin( dotResult4_g1585 ) * 43758.55 ) ));
				float temp_output_742_0_g1583 = lerpResult10_g1585;
				float normalizeResult811_g1583 = normalize( temp_output_742_0_g1583 );
				float3 normalizeResult439_g1583 = normalize( packedInput.ase_texcoord3.xyz );
				float DryLeafPositionMask443_g1583 = ( (distance( normalizeResult439_g1583 , float3( 0,0.8,0 ) )*1.0 + 0.0) * 1 );
				float4 lerpResult677_g1583 = lerp( ( _DryLeafColor * ( tex2DNode662_g1583.g * 2 ) ) , tex2DNode662_g1583 , saturate( (( ( tex2D( _NoiseMapGrayscale, uv_NoiseMapGrayscale669_g1583 ).r * (( _NormalizeSeasons )?( normalizeResult811_g1583 ):( temp_output_742_0_g1583 )) * DryLeafPositionMask443_g1583 ) - _SeasonChangeGlobal )*_DryLeavesScale + _DryLeavesOffset) ));
				float4 SeasonControl_Output676_g1583 = lerpResult677_g1583;
				Gradient gradient752_g1583 = NewGradient( 0, 2, 2, float4( 1, 0.276868, 0, 0 ), float4( 0, 1, 0.7818019, 1 ), 0, 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
				float4 transform754_g1583 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
				transform754_g1583.xyz = GetAbsolutePositionWS((transform754_g1583).xyz);
				float dotResult4_g1584 = dot( transform754_g1583.xy , float2( 12.9898,78.233 ) );
				float lerpResult10_g1584 = lerp( 0.0 , 1.0 , frac( ( sin( dotResult4_g1584 ) * 43758.55 ) ));
				float4 lerpResult515_g1583 = lerp( SeasonControl_Output676_g1583 , ( ( SeasonControl_Output676_g1583 * 0.5 ) + ( SampleGradient( gradient752_g1583, lerpResult10_g1584 ) * SeasonControl_Output676_g1583 ) ) , _ColorVariation);
				float2 uv_MaskMapRGBA505_g1583 = packedInput.ase_texcoord2.xy;
				float4 lerpResult521_g1583 = lerp( tex2D( _AlbedoMap, uv_AlbedoMap513_g1583 ) , lerpResult515_g1583 , (( _BranchMaskR )?( tex2D( _MaskMapRGBA, uv_MaskMapRGBA505_g1583 ).r ):( 1.0 )));
				float3 temp_output_465_0_g1583 = ( ( packedInput.ase_texcoord3.xyz * float3( 2,1.3,2 ) ) / 25.0 );
				float dotResult471_g1583 = dot( temp_output_465_0_g1583 , temp_output_465_0_g1583 );
				float3 normalizeResult457_g1583 = normalize( packedInput.ase_texcoord3.xyz );
				float SelfShading601_g1583 = saturate( (( pow( abs( saturate( dotResult471_g1583 ) ) , 1.5 ) + ( ( 1.0 - (distance( normalizeResult457_g1583 , float3( 0,0.8,0 ) )*0.5 + 0.0) ) * 0.6 ) )*0.92 + -0.16) );
				#ifdef _SELFSHADINGVERTEXCOLOR_ON
				float4 staticSwitch618_g1583 = ( lerpResult521_g1583 * (SelfShading601_g1583*_VertexLighting + _VertexShadow) );
				#else
				float4 staticSwitch618_g1583 = lerpResult521_g1583;
				#endif
				float4 GrassColorVariation_Output586_g1583 = staticSwitch618_g1583;
				float3 ase_worldPos = packedInput.ase_texcoord4.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float4 transform487_g1583 = mul(GetObjectToWorldMatrix(),float4( packedInput.ase_texcoord3.xyz , 0.0 ));
				transform487_g1583.xyz = GetAbsolutePositionWS((transform487_g1583).xyz);
				float dotResult566_g1583 = dot( float4( ase_worldViewDir , 0.0 ) , -( float4( -_DirectionalLightDatas[0].forward , 0.0 ) + ( (( _TranslucencyTreeTangents )?( float4( packedInput.ase_normal , 0.0 ) ):( transform487_g1583 )) * _TranslucencyRange ) ) );
				float2 uv_MaskMapRGBA516_g1583 = packedInput.ase_texcoord2.xy;
				float ase_lightIntensity = max( max( _DirectionalLightDatas[0].color.r, _DirectionalLightDatas[0].color.g ), _DirectionalLightDatas[0].color.b );
				float4 ase_lightColor = float4( _DirectionalLightDatas[0].color.rgb / ase_lightIntensity, ase_lightIntensity );
				float TobyTranslucency526_g1583 = ( saturate( dotResult566_g1583 ) * tex2D( _MaskMapRGBA, uv_MaskMapRGBA516_g1583 ).b * ase_lightColor.a );
				float TranslucencyIntensity616_g1583 = _TranslucencyPower;
				float4 Albedo_Output613_g1583 = ( ( _AlbedoColor * GrassColorVariation_Output586_g1583 ) * (1.0 + (TobyTranslucency526_g1583 - 0.0) * (TranslucencyIntensity616_g1583 - 1.0) / (1.0 - 0.0)) );
				
				float2 uv_NormalMap531_g1583 = packedInput.ase_texcoord2.xy;
				float3 unpack531_g1583 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap531_g1583 ), _NormalIntenisty );
				unpack531_g1583.z = lerp( 1, unpack531_g1583.z, saturate(_NormalIntenisty) );
				float3 tex2DNode531_g1583 = unpack531_g1583;
				float3 break539_g1583 = tex2DNode531_g1583;
				float3 appendResult552_g1583 = (float3(break539_g1583.x , break539_g1583.y , ( break539_g1583.z * isFrontFace )));
				float3 Normal_Output557_g1583 = (( _NormalBackFaceFixBranch )?( appendResult552_g1583 ):( tex2DNode531_g1583 ));
				
				float2 uv_MaskMapRGBA535_g1583 = packedInput.ase_texcoord2.xy;
				float4 tex2DNode535_g1583 = tex2D( _MaskMapRGBA, uv_MaskMapRGBA535_g1583 );
				float Smoothness_Output558_g1583 = ( tex2DNode535_g1583.a * _SmoothnessIntensity );
				
				float AoMapBase538_g1583 = tex2DNode535_g1583.g;
				float AmbientOcclusion_Output582_g1583 = pow( abs( AoMapBase538_g1583 ) , _AmbientOcclusionIntensity );
				
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord2.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				float translucency792_g1583 = saturate( ( 1.0 - tex2DNode535_g1583.b ) );
				float Translucency_Output818_g1583 = translucency792_g1583;
				
				surfaceDescription.BaseColor = Albedo_Output613_g1583.rgb;
				surfaceDescription.Normal = Normal_Output557_g1583;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = 0;
				surfaceDescription.Smoothness = Smoothness_Output558_g1583;
				surfaceDescription.Occlusion = AmbientOcclusion_Output582_g1583;
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = Translucency_Output818_g1583;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = _DiffusionProfile;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);
				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);
				LightTransportData lightTransportData = GetLightTransportData(surfaceData, builtinData, bsdfData);

				float4 res = float4( 0.0, 0.0, 0.0, 1.0 );
				UnityMetaInput metaInput;
				metaInput.Albedo = lightTransportData.diffuseColor.rgb;
				metaInput.Emission = lightTransportData.emissiveColor;

			#ifdef EDITOR_VISUALIZATION
				metaInput.VizUV = packedInput.VizUV;
				metaInput.LightCoord = packedInput.LightCoord;
			#endif
				res = UnityMetaFragment(metaInput);

				return res;
			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			Cull [_CullMode]
			ZWrite On
			ZClip [_ZClip]
			ZTest LEqual
			ColorMask 0

			HLSLPROGRAM
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_NEED_CULLFACE 1
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#pragma shader_feature_local _ _ALPHATEST_ON
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define _MATERIAL_FEATURE_TRANSMISSION 1
			#define _AMBIENT_OCCLUSION 1
			#define ASE_BAKEDGI 1
			#define ASE_BAKEDBACKGI 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140008

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma multi_compile_fragment _ SHADOWS_SHADOWMASK

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_SHADOWS

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _AlbedoMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout AlphaSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				// refraction ShadowCaster
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                    #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);

	            
                #if ASE_SRP_VERSION <=140008
				GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

				#if HAVE_DECALS
				if (_EnableDecals)
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif
                #endif
               

	            

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

                #if defined(DEBUG_DISPLAY)
                    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                    {
                        surfaceData.metallic = 0;
                    }
                    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
                #endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(AlphaSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.ase_texcoord.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord1.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS = inputMesh.tangentOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
			UNITY_SETUP_INSTANCE_ID(packedInput);

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				AlphaSurfaceDescription surfaceDescription = (AlphaSurfaceDescription)0;
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord1.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
				surfaceDescription.AlphaClipThresholdShadow = 0.5;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
				outputDepth += bias;
				#endif

				#ifdef WRITE_MSAA_DEPTH
				depthColor = packedInput.vmesh.positionCS.z;

				#ifdef _ALPHATOMASK_ON
				depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif
				#endif

				#if defined(WRITE_NORMAL_BUFFER)
				EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
				#endif

                #if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				DecalPrepassData decalPrepassData;
				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
                #endif
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "SceneSelectionPass"
			Tags { "LightMode"="SceneSelectionPass" }

			Cull Off

			HLSLPROGRAM
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_NEED_CULLFACE 1
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#pragma shader_feature_local _ _ALPHATEST_ON
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define _MATERIAL_FEATURE_TRANSMISSION 1
			#define _AMBIENT_OCCLUSION 1
			#define ASE_BAKEDGI 1
			#define ASE_BAKEDBACKGI 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140008

			#pragma editor_sync_compilation
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
		    #define SCENESELECTIONPASS 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _AlbedoMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SceneSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;

				//refraction SceneSelectionPass
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
                    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);

	            
                #if ASE_SRP_VERSION <=140008
				GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

				#if HAVE_DECALS
				if (_EnableDecals)
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif
                #endif
               

	            

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

                #if defined(DEBUG_DISPLAY)
                    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                   {
                        surfaceData.metallic = 0;
                   }
                     ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
                #endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(SceneSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;
				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.ase_texcoord.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord1.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord1.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS = inputMesh.tangentOS;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						, out float4 outColor : SV_Target0
						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SceneSurfaceDescription surfaceDescription = (SceneSurfaceDescription)0;
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord1.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

				outColor = float4( _ObjectId, _PassValue, 1.0, 1.0 );
			}
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthOnly"
			Tags { "LightMode"="DepthOnly" }

			Cull [_CullMode]
			ZWrite On

			Stencil
			{
				Ref [_StencilRefDepth]
				WriteMask [_StencilWriteMaskDepth]
				Comp Always
				Pass Replace
			}


			HLSLPROGRAM
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_NEED_CULLFACE 1
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#pragma shader_feature_local _ _ALPHATEST_ON
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define _MATERIAL_FEATURE_TRANSMISSION 1
			#define _AMBIENT_OCCLUSION 1
			#define ASE_BAKEDGI 1
			#define ASE_BAKEDBACKGI 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140008
			#if !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif //ASE_NEED_CULLFACE

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

            #pragma multi_compile _ WRITE_NORMAL_BUFFER
            #pragma multi_compile_fragment _ WRITE_MSAA_DEPTH
            #pragma multi_compile _ WRITE_DECAL_BUFFER

			#pragma vertex Vert
			#pragma fragment Frag

            #define SHADERPASS SHADERPASS_DEPTH_ONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif
        
            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif

            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _NormalMap;
			sampler2D _MaskMapRGBA;
			sampler2D _AlbedoMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_VFACE
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout SmoothSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);

				surfaceData.specularOcclusion = 1.0;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
				    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
				    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;

	            
                #if ASE_SRP_VERSION <=140008
				GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

				#if HAVE_DECALS
				if (_EnableDecals)
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif
                #endif
               

	            

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

                #if defined(DEBUG_DISPLAY)
                    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
                    {
                        surfaceData.metallic = 0;
                    }
                     ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData);
                #endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(SmoothSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

                float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

                PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalPrepassBuffer.hlsl"
			#endif

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh )
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.ase_texcoord.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord3.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord3.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif

				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS =  inputMesh.tangentOS ;

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
			UNITY_SETUP_INSTANCE_ID(packedInput);

				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				SmoothSurfaceDescription surfaceDescription = (SmoothSurfaceDescription)0;
				float2 uv_NormalMap531_g1583 = packedInput.ase_texcoord3.xy;
				float3 unpack531_g1583 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap531_g1583 ), _NormalIntenisty );
				unpack531_g1583.z = lerp( 1, unpack531_g1583.z, saturate(_NormalIntenisty) );
				float3 tex2DNode531_g1583 = unpack531_g1583;
				float3 break539_g1583 = tex2DNode531_g1583;
				float3 appendResult552_g1583 = (float3(break539_g1583.x , break539_g1583.y , ( break539_g1583.z * isFrontFace )));
				float3 Normal_Output557_g1583 = (( _NormalBackFaceFixBranch )?( appendResult552_g1583 ):( tex2DNode531_g1583 ));
				
				float2 uv_MaskMapRGBA535_g1583 = packedInput.ase_texcoord3.xy;
				float4 tex2DNode535_g1583 = tex2D( _MaskMapRGBA, uv_MaskMapRGBA535_g1583 );
				float Smoothness_Output558_g1583 = ( tex2DNode535_g1583.a * _SmoothnessIntensity );
				
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord3.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				surfaceDescription.Normal = Normal_Output557_g1583;
				surfaceDescription.Smoothness = Smoothness_Output558_g1583;
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription, input, V, posInput, surfaceData, builtinData);

                #if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
				outputDepth = posInput.deviceDepth;
				#endif

                #if SHADERPASS == SHADERPASS_SHADOWS
                float bias = max(abs(ddx(posInput.deviceDepth)), abs(ddy(posInput.deviceDepth))) * _SlopeScaleDepthBias;
                outputDepth += bias;
                #endif

                #ifdef SCENESELECTIONPASS
                outColor = float4(_ObjectId, _PassValue, 1.0, 1.0);
                #elif defined(SCENEPICKINGPASS)
                outColor = unity_SelectionID;
                #else
                #ifdef WRITE_MSAA_DEPTH
                depthColor = packedInput.vmesh.positionCS.z;
                depthColor.a = SharpenAlpha(builtinData.opacity, builtinData.alphaClipTreshold);
				#endif
                #endif

                #if defined(WRITE_NORMAL_BUFFER)
                EncodeIntoNormalBuffer(ConvertSurfaceDataToNormalData(surfaceData), outNormalBuffer);
                #endif

				#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
				DecalPrepassData decalPrepassData;
				decalPrepassData.geomNormalWS = surfaceData.geomNormalWS;
				decalPrepassData.decalLayerMask = GetMeshRenderingDecalLayer();
				EncodeIntoDecalPrepassBuffer(decalPrepassData, outDecalBuffer);
				#endif

			}

			ENDHLSL
		}

		
		Pass
		{
			
			Name "Forward"
			Tags { "LightMode"="Forward" }

			Blend [_SrcBlend] [_DstBlend], [_AlphaSrcBlend] [_AlphaDstBlend]
			Blend 1 SrcAlpha OneMinusSrcAlpha

			Cull [_CullModeForward]
			ZTest [_ZTestDepthEqualForOpaque]
			ZWrite [_ZWrite]

			Stencil
			{
				Ref [_StencilRef]
				WriteMask [_StencilWriteMask]
				Comp Always
				Pass Replace
			}


            ColorMask [_ColorMaskTransparentVelOne] 1
            ColorMask [_ColorMaskTransparentVelTwo] 2

			HLSLPROGRAM
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_NEED_CULLFACE 1
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#pragma shader_feature_local _ _ALPHATEST_ON
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define _MATERIAL_FEATURE_TRANSMISSION 1
			#define _AMBIENT_OCCLUSION 1
			#define ASE_BAKEDGI 1
			#define ASE_BAKEDBACKGI 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140008
			#if !defined(ASE_NEED_CULLFACE)
			#define ASE_NEED_CULLFACE 1
			#endif //ASE_NEED_CULLFACE

			#pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

            #pragma multi_compile_fragment _ SHADOWS_SHADOWMASK
			#pragma multi_compile_fragment SHADOW_LOW SHADOW_MEDIUM SHADOW_HIGH
            #pragma multi_compile_fragment AREA_SHADOW_MEDIUM AREA_SHADOW_HIGH
            #pragma multi_compile_fragment PROBE_VOLUMES_OFF PROBE_VOLUMES_L1 PROBE_VOLUMES_L2
            #pragma multi_compile_fragment SCREEN_SPACE_SHADOWS_OFF SCREEN_SPACE_SHADOWS_ON
            #pragma multi_compile_fragment USE_FPTL_LIGHTLIST USE_CLUSTERED_LIGHTLIST

            #pragma multi_compile _ DEBUG_DISPLAY
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile_fragment DECALS_OFF DECALS_3RT DECALS_4RT
            #pragma multi_compile_fragment _ DECAL_SURFACE_GRADIENT

			#ifndef SHADER_STAGE_FRAGMENT
			#define SHADOW_LOW
			#define USE_FPTL_LIGHTLIST
			#endif

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_FORWARD
		    #define HAS_LIGHTLOOP 1

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

		    #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
			#undef  _REFRACTION_PLANE
			#undef  _REFRACTION_SPHERE
			#define _REFRACTION_THIN
		    #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

			CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
			float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
			int _ObjectId;
			int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _AlbedoMap;
			sampler2D _NoiseMapGrayscale;
			sampler2D _MaskMapRGBA;
			sampler2D _NormalMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/Lighting.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoopDef.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Lighting/LightLoop/LightLoop.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/LitDecalData.hlsl"

        	#ifdef HAVE_VFX_MODIFICATION
        	#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/VisualEffectVertex.hlsl"
        	#endif

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_FRAG_POSITION
			#define ASE_NEEDS_FRAG_WORLD_VIEW_DIR
			#define ASE_NEEDS_FRAG_VFACE
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON
			#pragma shader_feature_local _SELFSHADINGVERTEXCOLOR_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float3 ase_normal : NORMAL;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			
			
			float4 SampleGradient( Gradient gradient, float time )
			{
				float3 color = gradient.colors[0].rgb;
				UNITY_UNROLL
				for (int c = 1; c < 8; c++)
				{
				float colorPos = saturate((time - gradient.colors[c-1].w) / ( 0.00001 + (gradient.colors[c].w - gradient.colors[c-1].w)) * step(c, gradient.colorsLength-1));
				color = lerp(color, gradient.colors[c].rgb, lerp(colorPos, step(0.01, colorPos), gradient.type));
				}
				#ifndef UNITY_COLORSPACE_GAMMA
				color = SRGBToLinear(color);
				#endif
				float alpha = gradient.alphas[0].x;
				UNITY_UNROLL
				for (int a = 1; a < 8; a++)
				{
				float alphaPos = saturate((time - gradient.alphas[a-1].y) / ( 0.00001 + (gradient.alphas[a].y - gradient.alphas[a-1].y)) * step(a, gradient.alphasLength-1));
				alpha = lerp(alpha, gradient.alphas[a].x, lerp(alphaPos, step(0.01, alphaPos), gradient.type));
				}
				return float4(color, alpha);
			}
			
			float3 ASEBakedGI( float3 positionWS, float3 normalWS,  uint2 positionSS, float2 uvStaticLightmap, float2 uvDynamicLightmap )
			{
				float3 positionRWS = GetCameraRelativePositionWS( positionWS );
				return SampleBakedGI( positionRWS, normalWS, positionSS, uvStaticLightmap, uvDynamicLightmap );
			}
			

			void BuildSurfaceData(FragInputs fragInputs, inout GlobalSurfaceDescription surfaceDescription, float3 V, PositionInputs posInput, out SurfaceData surfaceData, out float3 bentNormalWS)
			{
				ZERO_INITIALIZE(SurfaceData, surfaceData);
				surfaceData.specularOcclusion = 1.0;

				surfaceData.baseColor =                 surfaceDescription.BaseColor;
				surfaceData.perceptualSmoothness =		surfaceDescription.Smoothness;
				surfaceData.ambientOcclusion =			surfaceDescription.Occlusion;
				surfaceData.metallic =					surfaceDescription.Metallic;
				surfaceData.coatMask =					surfaceDescription.CoatMask;

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceData.specularOcclusion =			surfaceDescription.SpecularOcclusion;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceData.subsurfaceMask =			surfaceDescription.SubsurfaceMask;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceData.thickness = 				surfaceDescription.Thickness;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceData.transmissionMask =			surfaceDescription.TransmissionMask;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceData.diffusionProfileHash =		asuint(surfaceDescription.DiffusionProfile);
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceData.specularColor =				surfaceDescription.Specular;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceData.anisotropy =				surfaceDescription.Anisotropy;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceData.iridescenceMask =			surfaceDescription.IridescenceMask;
				surfaceData.iridescenceThickness =		surfaceDescription.IridescenceThickness;
				#endif

				// refraction
                #if defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE) || defined(_REFRACTION_THIN)
                    if (_EnableSSRefraction)
                    {
                        surfaceData.ior =                       surfaceDescription.RefractionIndex;
                        surfaceData.transmittanceColor =        surfaceDescription.RefractionColor;
                        surfaceData.atDistance =                surfaceDescription.RefractionDistance;
        
                        surfaceData.transmittanceMask = (1.0 - surfaceDescription.Alpha);
                        surfaceDescription.Alpha = 1.0;
                    }
                    else
                    {
                        surfaceData.ior = 1.0;
                        surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                        surfaceData.atDistance = 1.0;
                        surfaceData.transmittanceMask = 0.0;
                        surfaceDescription.Alpha = 1.0;
                    }
                #else
                    surfaceData.ior = 1.0;
                    surfaceData.transmittanceColor = float3(1.0, 1.0, 1.0);
                    surfaceData.atDistance = 1.0;
                    surfaceData.transmittanceMask = 0.0;
                #endif

				surfaceData.materialFeatures = MATERIALFEATUREFLAGS_LIT_STANDARD;

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SUBSURFACE_SCATTERING;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_TRANSMISSION;
				#endif

                #ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_ANISOTROPY;
                    surfaceData.normalWS = float3(0, 1, 0);
                #endif

				#ifdef _MATERIAL_FEATURE_CLEAR_COAT
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_CLEAR_COAT;
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_IRIDESCENCE;
				#endif

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
                    surfaceData.materialFeatures |= MATERIALFEATUREFLAGS_LIT_SPECULAR_COLOR;
				#endif

				#if defined (_MATERIAL_FEATURE_SPECULAR_COLOR) && defined (_ENERGY_CONSERVING_SPECULAR)
                    surfaceData.baseColor *= ( 1.0 - Max3( surfaceData.specularColor.r, surfaceData.specularColor.g, surfaceData.specularColor.b ) );
				#endif

				#ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
				#else
                    float3 doubleSidedConstants = float3( 1.0, 1.0, 1.0 );
				#endif

				float3 normalTS = float3(0.0f, 0.0f, 1.0f);
				normalTS = surfaceDescription.Normal;

	            
                #if ASE_SRP_VERSION <=140008
				GetNormalWS(fragInputs, normalTS, surfaceData.normalWS, doubleSidedConstants);

				#if HAVE_DECALS
				if (_EnableDecals)
				{
					DecalSurfaceData decalSurfaceData = GetDecalSurfaceData(posInput, fragInputs, surfaceDescription.Alpha);
					ApplyDecalToSurfaceData(decalSurfaceData, fragInputs.tangentToWorld[2], surfaceData);
				}
				#endif
                #endif
               

	            

				surfaceData.geomNormalWS = fragInputs.tangentToWorld[2];
                surfaceData.tangentWS = normalize(fragInputs.tangentToWorld[0].xyz );
                surfaceData.tangentWS = Orthonormalize(surfaceData.tangentWS, surfaceData.normalWS);

				bentNormalWS = surfaceData.normalWS;

				#ifdef ASE_BENT_NORMAL
                    GetNormalWS( fragInputs, surfaceDescription.BentNormal, bentNormalWS, doubleSidedConstants );
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
                    surfaceData.tangentWS = TransformTangentToWorld(surfaceDescription.Tangent, fragInputs.tangentToWorld);
				#endif

				#if defined(DEBUG_DISPLAY)
				    if (_DebugMipMapMode != DEBUGMIPMAPMODE_NONE)
				    {
					   surfaceData.metallic = 0;
				    }
				    ApplyDebugToSurfaceData(fragInputs.tangentToWorld, surfaceData); 
				#endif

                #if defined(_SPECULAR_OCCLUSION_CUSTOM)
                #elif defined(_SPECULAR_OCCLUSION_FROM_AO_BENT_NORMAL)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromBentAO(V, bentNormalWS, surfaceData.normalWS, surfaceData.ambientOcclusion, PerceptualSmoothnessToPerceptualRoughness(surfaceData.perceptualSmoothness));
                #elif defined(_AMBIENT_OCCLUSION) && defined(_SPECULAR_OCCLUSION_FROM_AO)
                    surfaceData.specularOcclusion = GetSpecularOcclusionFromAmbientOcclusion(ClampNdotV(dot(surfaceData.normalWS, V)), surfaceData.ambientOcclusion, PerceptualSmoothnessToRoughness(surfaceData.perceptualSmoothness));
                #endif

                #ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
                    surfaceData.perceptualSmoothness = GeometricNormalFiltering(surfaceData.perceptualSmoothness, fragInputs.tangentToWorld[2], surfaceDescription.SpecularAAScreenSpaceVariance, surfaceDescription.SpecularAAThreshold);
                #endif
			}

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(GlobalSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif  
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);
			}

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.ase_texcoord.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.xy = inputMesh.ase_texcoord.xy;
				outputPackedVaryingsMeshToPS.ase_texcoord8 = float4(inputMesh.positionOS,1);
				outputPackedVaryingsMeshToPS.ase_normal = inputMesh.normalOS;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue = FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS = inputMesh.tangentOS;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.uv1 = v.uv1;
				o.uv2 = v.uv2;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.uv1 = patch[0].uv1 * bary.x + patch[1].uv1 * bary.y + patch[2].uv1 * bary.z;
				o.uv2 = patch[0].uv2 * bary.x + patch[1].uv2 * bary.y + patch[2].uv2 * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplayMaterial.hlsl"

            #ifdef UNITY_VIRTUAL_TEXTURING
                #ifdef OUTPUT_SPLIT_LIGHTING
                   #define DIFFUSE_LIGHTING_TARGET SV_Target2
                   #define SSS_BUFFER_TARGET SV_Target3
                #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
                   #define MOTION_VECTOR_TARGET SV_Target2
            	#endif
            #if defined(SHADER_API_PSSL)
            	#pragma PSSL_target_output_format(target 1 FMT_32_ABGR)
            #endif
            #else
                #ifdef OUTPUT_SPLIT_LIGHTING
                #define DIFFUSE_LIGHTING_TARGET SV_Target1
                #define SSS_BUFFER_TARGET SV_Target2
                #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
                #define MOTION_VECTOR_TARGET SV_Target1
                #endif
            #endif

			void Frag(PackedVaryingsMeshToPS packedInput
				, out float4 outColor:SV_Target0
            #ifdef UNITY_VIRTUAL_TEXTURING
				, out float4 outVTFeedback : SV_Target1
            #endif
            #ifdef OUTPUT_SPLIT_LIGHTING
				, out float4 outDiffuseLighting : DIFFUSE_LIGHTING_TARGET
				, OUTPUT_SSSBUFFER(outSSSBuffer) : SSS_BUFFER_TARGET
            #elif defined(_WRITE_TRANSPARENT_MOTION_VECTOR)
				, out float4 outMotionVec : MOTION_VECTOR_TARGET
            #endif
            #ifdef _DEPTHOFFSET_ON
				, out float outputDepth : DEPTH_OFFSET_SEMANTIC
            #endif
		    
						)
			{
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outMotionVec = float4(2.0, 0.0, 0.0, 1.0);
				#endif

				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX( packedInput );
				UNITY_SETUP_INSTANCE_ID( packedInput );
				float3 positionRWS = packedInput.positionRWS.xyz;
				float3 normalWS = packedInput.normalWS.xyz;
				float4 tangentWS = packedInput.tangentWS.xyzw;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);
				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;
				input.positionRWS = positionRWS;
				input.tangentToWorld = BuildTangentToWorld(tangentWS, normalWS);
				input.texCoord1 = packedInput.uv1.xyzw;
				input.texCoord2 = packedInput.uv2.xyzw;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE(packedInput.cullFace, true, false);
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				

				
				AdjustFragInputsToOffScreenRendering(input, _OffScreenRendering > 0, _OffScreenDownsampleFactor);
			

				uint2 tileIndex = uint2(input.positionSS.xy) / GetTileSize ();

				PositionInputs posInput = GetPositionInput( input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz, tileIndex );

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				GlobalSurfaceDescription surfaceDescription = (GlobalSurfaceDescription)0;
				float2 uv_AlbedoMap513_g1583 = packedInput.ase_texcoord7.xy;
				float2 uv_AlbedoMap662_g1583 = packedInput.ase_texcoord7.xy;
				float4 tex2DNode662_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap662_g1583 );
				float2 uv_NoiseMapGrayscale669_g1583 = packedInput.ase_texcoord7.xy;
				float4 transform741_g1583 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
				transform741_g1583.xyz = GetAbsolutePositionWS((transform741_g1583).xyz);
				float dotResult4_g1585 = dot( transform741_g1583.xy , float2( 12.9898,78.233 ) );
				float lerpResult10_g1585 = lerp( 0.0 , 1.0 , frac( ( sin( dotResult4_g1585 ) * 43758.55 ) ));
				float temp_output_742_0_g1583 = lerpResult10_g1585;
				float normalizeResult811_g1583 = normalize( temp_output_742_0_g1583 );
				float3 normalizeResult439_g1583 = normalize( packedInput.ase_texcoord8.xyz );
				float DryLeafPositionMask443_g1583 = ( (distance( normalizeResult439_g1583 , float3( 0,0.8,0 ) )*1.0 + 0.0) * 1 );
				float4 lerpResult677_g1583 = lerp( ( _DryLeafColor * ( tex2DNode662_g1583.g * 2 ) ) , tex2DNode662_g1583 , saturate( (( ( tex2D( _NoiseMapGrayscale, uv_NoiseMapGrayscale669_g1583 ).r * (( _NormalizeSeasons )?( normalizeResult811_g1583 ):( temp_output_742_0_g1583 )) * DryLeafPositionMask443_g1583 ) - _SeasonChangeGlobal )*_DryLeavesScale + _DryLeavesOffset) ));
				float4 SeasonControl_Output676_g1583 = lerpResult677_g1583;
				Gradient gradient752_g1583 = NewGradient( 0, 2, 2, float4( 1, 0.276868, 0, 0 ), float4( 0, 1, 0.7818019, 1 ), 0, 0, 0, 0, 0, 0, float2( 1, 0 ), float2( 1, 1 ), 0, 0, 0, 0, 0, 0 );
				float4 transform754_g1583 = mul(GetObjectToWorldMatrix(),float4( 0,0,0,1 ));
				transform754_g1583.xyz = GetAbsolutePositionWS((transform754_g1583).xyz);
				float dotResult4_g1584 = dot( transform754_g1583.xy , float2( 12.9898,78.233 ) );
				float lerpResult10_g1584 = lerp( 0.0 , 1.0 , frac( ( sin( dotResult4_g1584 ) * 43758.55 ) ));
				float4 lerpResult515_g1583 = lerp( SeasonControl_Output676_g1583 , ( ( SeasonControl_Output676_g1583 * 0.5 ) + ( SampleGradient( gradient752_g1583, lerpResult10_g1584 ) * SeasonControl_Output676_g1583 ) ) , _ColorVariation);
				float2 uv_MaskMapRGBA505_g1583 = packedInput.ase_texcoord7.xy;
				float4 lerpResult521_g1583 = lerp( tex2D( _AlbedoMap, uv_AlbedoMap513_g1583 ) , lerpResult515_g1583 , (( _BranchMaskR )?( tex2D( _MaskMapRGBA, uv_MaskMapRGBA505_g1583 ).r ):( 1.0 )));
				float3 temp_output_465_0_g1583 = ( ( packedInput.ase_texcoord8.xyz * float3( 2,1.3,2 ) ) / 25.0 );
				float dotResult471_g1583 = dot( temp_output_465_0_g1583 , temp_output_465_0_g1583 );
				float3 normalizeResult457_g1583 = normalize( packedInput.ase_texcoord8.xyz );
				float SelfShading601_g1583 = saturate( (( pow( abs( saturate( dotResult471_g1583 ) ) , 1.5 ) + ( ( 1.0 - (distance( normalizeResult457_g1583 , float3( 0,0.8,0 ) )*0.5 + 0.0) ) * 0.6 ) )*0.92 + -0.16) );
				#ifdef _SELFSHADINGVERTEXCOLOR_ON
				float4 staticSwitch618_g1583 = ( lerpResult521_g1583 * (SelfShading601_g1583*_VertexLighting + _VertexShadow) );
				#else
				float4 staticSwitch618_g1583 = lerpResult521_g1583;
				#endif
				float4 GrassColorVariation_Output586_g1583 = staticSwitch618_g1583;
				float4 transform487_g1583 = mul(GetObjectToWorldMatrix(),float4( packedInput.ase_texcoord8.xyz , 0.0 ));
				transform487_g1583.xyz = GetAbsolutePositionWS((transform487_g1583).xyz);
				float dotResult566_g1583 = dot( float4( V , 0.0 ) , -( float4( -_DirectionalLightDatas[0].forward , 0.0 ) + ( (( _TranslucencyTreeTangents )?( float4( packedInput.ase_normal , 0.0 ) ):( transform487_g1583 )) * _TranslucencyRange ) ) );
				float2 uv_MaskMapRGBA516_g1583 = packedInput.ase_texcoord7.xy;
				float ase_lightIntensity = max( max( _DirectionalLightDatas[0].color.r, _DirectionalLightDatas[0].color.g ), _DirectionalLightDatas[0].color.b );
				float4 ase_lightColor = float4( _DirectionalLightDatas[0].color.rgb / ase_lightIntensity, ase_lightIntensity );
				float TobyTranslucency526_g1583 = ( saturate( dotResult566_g1583 ) * tex2D( _MaskMapRGBA, uv_MaskMapRGBA516_g1583 ).b * ase_lightColor.a );
				float TranslucencyIntensity616_g1583 = _TranslucencyPower;
				float4 Albedo_Output613_g1583 = ( ( _AlbedoColor * GrassColorVariation_Output586_g1583 ) * (1.0 + (TobyTranslucency526_g1583 - 0.0) * (TranslucencyIntensity616_g1583 - 1.0) / (1.0 - 0.0)) );
				
				float2 uv_NormalMap531_g1583 = packedInput.ase_texcoord7.xy;
				float3 unpack531_g1583 = UnpackNormalScale( tex2D( _NormalMap, uv_NormalMap531_g1583 ), _NormalIntenisty );
				unpack531_g1583.z = lerp( 1, unpack531_g1583.z, saturate(_NormalIntenisty) );
				float3 tex2DNode531_g1583 = unpack531_g1583;
				float3 break539_g1583 = tex2DNode531_g1583;
				float3 appendResult552_g1583 = (float3(break539_g1583.x , break539_g1583.y , ( break539_g1583.z * isFrontFace )));
				float3 Normal_Output557_g1583 = (( _NormalBackFaceFixBranch )?( appendResult552_g1583 ):( tex2DNode531_g1583 ));
				
				float2 uv_MaskMapRGBA535_g1583 = packedInput.ase_texcoord7.xy;
				float4 tex2DNode535_g1583 = tex2D( _MaskMapRGBA, uv_MaskMapRGBA535_g1583 );
				float Smoothness_Output558_g1583 = ( tex2DNode535_g1583.a * _SmoothnessIntensity );
				
				float AoMapBase538_g1583 = tex2DNode535_g1583.g;
				float AmbientOcclusion_Output582_g1583 = pow( abs( AoMapBase538_g1583 ) , _AmbientOcclusionIntensity );
				
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord7.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				float translucency792_g1583 = saturate( ( 1.0 - tex2DNode535_g1583.b ) );
				float Translucency_Output818_g1583 = translucency792_g1583;
				
				float3 bakedGI2874 = ASEBakedGI( float3( 0,0,0 ), float3( 0,0,0 ), int2( 0,0 ), float2( 0,0 ), float2( 0,0 ) );
				float3 temp_output_2873_0 = ( float3( 0,0,0 ) * bakedGI2874 );
				
				surfaceDescription.BaseColor = Albedo_Output613_g1583.rgb;
				surfaceDescription.Normal = Normal_Output557_g1583;
				surfaceDescription.BentNormal = float3( 0, 0, 1 );
				surfaceDescription.CoatMask = 0;
				surfaceDescription.Metallic = 0;

				#ifdef _MATERIAL_FEATURE_SPECULAR_COLOR
				surfaceDescription.Specular = 0;
				#endif

				surfaceDescription.Emission = 0;
				surfaceDescription.Smoothness = Smoothness_Output558_g1583;
				surfaceDescription.Occlusion = AmbientOcclusion_Output582_g1583;
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold = _AlphaCutoff;
				#endif

				#ifdef _SPECULAR_OCCLUSION_CUSTOM
				surfaceDescription.SpecularOcclusion = 0;
				#endif

				#ifdef _ENABLE_GEOMETRIC_SPECULAR_AA
				surfaceDescription.SpecularAAScreenSpaceVariance = 0;
				surfaceDescription.SpecularAAThreshold = 0;
				#endif

				#if defined(_HAS_REFRACTION) || defined(_MATERIAL_FEATURE_TRANSMISSION)
				surfaceDescription.Thickness = Translucency_Output818_g1583;
				#endif

				#ifdef _HAS_REFRACTION
				surfaceDescription.RefractionIndex = 1;
				surfaceDescription.RefractionColor = float3( 1, 1, 1 );
				surfaceDescription.RefractionDistance = 0;
				#endif

				#ifdef _MATERIAL_FEATURE_SUBSURFACE_SCATTERING
				surfaceDescription.SubsurfaceMask = 1;
				#endif

				#ifdef _MATERIAL_FEATURE_TRANSMISSION
				surfaceDescription.TransmissionMask = 1;
				#endif

				#if defined( _MATERIAL_FEATURE_SUBSURFACE_SCATTERING ) || defined( _MATERIAL_FEATURE_TRANSMISSION )
				surfaceDescription.DiffusionProfile = _DiffusionProfile;
				#endif

				#ifdef _MATERIAL_FEATURE_ANISOTROPY
				surfaceDescription.Anisotropy = 1;
				surfaceDescription.Tangent = float3( 1, 0, 0 );
				#endif

				#ifdef _MATERIAL_FEATURE_IRIDESCENCE
				surfaceDescription.IridescenceMask = 0;
				surfaceDescription.IridescenceThickness = 0;
				#endif

				#ifdef ASE_BAKEDGI
				surfaceDescription.BakedGI = (( _BakedGIONOFF )?( temp_output_2873_0 ):( float3( 0,0,0 ) ));
				#endif

				#ifdef ASE_BAKEDBACKGI
				surfaceDescription.BakedBackGI = temp_output_2873_0;
				#endif

				#ifdef _DEPTHOFFSET_ON
				surfaceDescription.DepthOffset = 0;
				#endif

				#ifdef UNITY_VIRTUAL_TEXTURING
				surfaceDescription.VTPackedFeedback = float4(1.0f,1.0f,1.0f,1.0f);
				#endif

				SurfaceData surfaceData;
				BuiltinData builtinData;
				GetSurfaceAndBuiltinData(surfaceDescription,input, V, posInput, surfaceData, builtinData);

				BSDFData bsdfData = ConvertSurfaceDataToBSDFData(input.positionSS.xy, surfaceData);

				PreLightData preLightData = GetPreLightData(V, posInput, bsdfData);

				outColor = float4(0.0, 0.0, 0.0, 0.0);

				#ifdef DEBUG_DISPLAY
				#ifdef OUTPUT_SPLIT_LIGHTING
					outDiffuseLighting = float4(0, 0, 0, 1);
					ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
				#endif

			    bool viewMaterial = GetMaterialDebugColor(outColor, input, builtinData, posInput, surfaceData, bsdfData);

				if (!viewMaterial)
				{
					if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_DIFFUSE_COLOR || _DebugFullScreenMode == FULLSCREENDEBUGMODE_VALIDATE_SPECULAR_COLOR)
					{
						float3 result = float3(0.0, 0.0, 0.0);
						GetPBRValidatorDebug(surfaceData, result);
						outColor = float4(result, 1.0f);
					}
					else if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_TRANSPARENCY_OVERDRAW)
					{
						float4 result = _DebugTransparencyOverdrawWeight * float4(TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_COST, TRANSPARENCY_OVERDRAW_A);
						outColor = result;
					}
					else
                #endif
					{
                #ifdef _SURFACE_TYPE_TRANSPARENT
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_TRANSPARENT;
                #else
						uint featureFlags = LIGHT_FEATURE_MASK_FLAGS_OPAQUE;
                #endif
						LightLoopOutput lightLoopOutput;
						LightLoop(V, posInput, preLightData, bsdfData, builtinData, featureFlags, lightLoopOutput);

						// Alias
						float3 diffuseLighting = lightLoopOutput.diffuseLighting;
						float3 specularLighting = lightLoopOutput.specularLighting;

						diffuseLighting *= GetCurrentExposureMultiplier();
						specularLighting *= GetCurrentExposureMultiplier();

                #ifdef OUTPUT_SPLIT_LIGHTING
						if (_EnableSubsurfaceScattering != 0 && ShouldOutputSplitLighting(bsdfData))
						{
							outColor = float4(specularLighting, 1.0);
							outDiffuseLighting = float4(TagLightingForSSS(diffuseLighting), 1.0);
						}
						else
						{
							outColor = float4(diffuseLighting + specularLighting, 1.0);
							outDiffuseLighting = float4(0, 0, 0, 1);
						}
						ENCODE_INTO_SSSBUFFER(surfaceData, posInput.positionSS, outSSSBuffer);
                #else
						outColor = ApplyBlendMode(diffuseLighting, specularLighting, builtinData.opacity);
						outColor = EvaluateAtmosphericScattering(posInput, V, outColor);
                #endif

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
						float4 VPASSpositionCS = float4(packedInput.vpassPositionCS.xy, 0.0, packedInput.vpassPositionCS.z);
						float4 VPASSpreviousPositionCS = float4(packedInput.vpassPreviousPositionCS.xy, 0.0, packedInput.vpassPreviousPositionCS.z);
						bool forceNoMotion = any(unity_MotionVectorsParams.yw == 0.0);
                #if defined(HAVE_VFX_MODIFICATION) && !VFX_FEATURE_MOTION_VECTORS
                        forceNoMotion = true;
                #endif
				        if (!forceNoMotion)
						{
							float2 motionVec = CalculateMotionVector(VPASSpositionCS, VPASSpreviousPositionCS);
							EncodeMotionVector(motionVec * 0.5, outMotionVec);
							outMotionVec.zw = 1.0;
						}
				#endif
				}

				#ifdef DEBUG_DISPLAY
				}
				#endif

				#ifdef _DEPTHOFFSET_ON
				outputDepth = posInput.deviceDepth;
				#endif

                #ifdef UNITY_VIRTUAL_TEXTURING
				    float vtAlphaValue = builtinData.opacity;
                    #if defined(HAS_REFRACTION) && HAS_REFRACTION
					vtAlphaValue = 1.0f - bsdfData.transmittanceMask;
                #endif
				outVTFeedback = PackVTFeedbackWithAlpha(builtinData.vtPackedFeedback, input.positionSS.xy, vtAlphaValue);
                #endif

			}
			ENDHLSL
		}

		
		Pass
        {
			
            Name "ScenePickingPass"
            Tags { "LightMode"="Picking" }

            Cull [_CullMode]

            HLSLPROGRAM
			#define SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			#define _SPECULAR_OCCLUSION_FROM_AO 1
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
			#define ASE_NEED_CULLFACE 1
			#pragma shader_feature_local _ _DOUBLESIDED_ON
			#pragma shader_feature_local _ _ALPHATEST_ON
			#pragma multi_compile _ LOD_FADE_CROSSFADE
			#define _MATERIAL_FEATURE_TRANSMISSION 1
			#define _AMBIENT_OCCLUSION 1
			#define ASE_BAKEDGI 1
			#define ASE_BAKEDBACKGI 1
			#define HAVE_MESH_MODIFICATION
			#define ASE_SRP_VERSION 140008

			#pragma editor_sync_compilation
            #pragma multi_compile _ DOTS_INSTANCING_ON

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#pragma vertex Vert
			#pragma fragment Frag

			#define SHADERPASS SHADERPASS_DEPTH_ONLY
			#define SCENEPICKINGPASS 1

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT
			#define VARYINGS_NEED_TANGENT_TO_WORLD

            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
        	#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
            #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

            //#if !defined(SHADER_STAGE_RAY_TRACING) && SHADERPASS != SHADERPASS_RAYTRACING_GBUFFER && SHADERPASS != SHADERPASS_FULL_SCREEN_DEBUG
            //#define FRAG_INPUTS_ENABLE_STRIPPING
            //#endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

            #ifdef RAYTRACING_SHADER_GRAPH_DEFAULT
                #define RAYTRACING_SHADER_GRAPH_HIGH
            #endif

            #ifdef RAYTRACING_SHADER_GRAPH_RAYTRACED
                #define RAYTRACING_SHADER_GRAPH_LOW
            #endif

            #ifndef SHADER_UNLIT
            #if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
                #define VARYINGS_NEED_CULLFACE
            #endif
            #endif

			#if defined(_DOUBLESIDED_ON) && !defined(ASE_NEED_CULLFACE)
			    #define ASE_NEED_CULLFACE 1
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
			#define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

            #if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
            #if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
                #define WRITE_NORMAL_BUFFER
            #endif
            #endif

            #ifndef DEBUG_DISPLAY
                #if !defined(_SURFACE_TYPE_TRANSPARENT)
                    #if SHADERPASS == SHADERPASS_FORWARD
                    #define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
                    #elif SHADERPASS == SHADERPASS_GBUFFER
                    #define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
                    #endif
                #endif
            #endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif
	
            CBUFFER_START( UnityPerMaterial )
			float4 _AlbedoColor;
			float4 _DryLeafColor;
			float _GlobalWindStrength;
			float _AmbientOcclusionIntensity;
			float _SmoothnessIntensity;
			float _NormalIntenisty;
			float _NormalBackFaceFixBranch;
			float _TranslucencyPower;
			float _TranslucencyRange;
			float _TranslucencyTreeTangents;
			float _VertexShadow;
			float _VertexLighting;
			float _BranchMaskR;
			float _ColorVariation;
			float _DryLeavesOffset;
			float _DryLeavesScale;
			float _SeasonChangeGlobal;
			float _NormalizeSeasons;
			float _PivotSway;
			float _GlobalFlutterIntensity;
			float _SwitchVGreenToRGBA;
			float _StrongWindSpeed;
			float _BranchWindSmall;
			float _CenterofMass;
			float _BranchWindLarge;
			float _Hardness;
			float _Radius;
			float _DiffusionProfile;
			float _BakedGIONOFF;
			float4 _EmissionColor;
			float _AlphaCutoff;
			float _RenderQueueType;
			#ifdef _ADD_PRECOMPUTED_VELOCITY
			    float _AddPrecomputedVelocity;
			#endif
			float _StencilRef;
			float _StencilWriteMask;
			float _StencilRefDepth;
			float _StencilWriteMaskDepth;
			float _StencilRefMV;
			float _StencilWriteMaskMV;
			float _StencilRefDistortionVec;
			float _StencilWriteMaskDistortionVec;
			float _StencilWriteMaskGBuffer;
			float _StencilRefGBuffer;
			float _ZTestGBuffer;
			float _RequireSplitLighting;
			float _ReceivesSSR;
			float _SurfaceType;
			float _BlendMode;
            #ifdef SUPPORT_BLENDMODE_PRESERVE_SPECULAR_LIGHTING
			    float _EnableBlendModePreserveSpecularLighting;
            #endif
			float _SrcBlend;
			float _DstBlend;
			float _AlphaSrcBlend;
			float _AlphaDstBlend;
			float _ZWrite;
			float _TransparentZWrite;
			float _CullMode;
			float _TransparentSortPriority;
			float _EnableFogOnTransparent;
			float _CullModeForward;
			float _TransparentCullMode;
			float _ZTestDepthEqualForOpaque;
			float _ZTestTransparent;
			float _TransparentBackfaceEnable;
			float _AlphaCutoffEnable;
			float _UseShadowThreshold;
			float _DoubleSidedEnable;
			float _DoubleSidedNormalMode;
			float4 _DoubleSidedConstants;
			#ifdef ASE_TESSELLATION
			    float _TessPhongStrength;
			    float _TessValue;
			    float _TessMin;
			    float _TessMax;
			    float _TessEdgeLength;
			    float _TessMaxDisp;
			#endif
			CBUFFER_END

            #ifdef SCENEPICKINGPASS
            float4 _SelectionID;
            #endif

            #ifdef SCENESELECTIONPASS
            int _ObjectId;
            int _PassValue;
            #endif

			float4x4 unity_CameraProjection;
			float4x4 unity_CameraInvProjection;
			float4x4 unity_WorldToCamera;
			float4x4 unity_CameraToWorld;
			sampler2D _WindNoise;
			sampler2D _AlbedoMap;


            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/PickingSpaceTransforms.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Decal/DecalUtilities.hlsl"

			#define ASE_NEEDS_VERT_POSITION
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _WINDTYPE_GENTLEBREEZE _WINDTYPE_WINDOFF
			#pragma shader_feature_local _LEAFFLUTTER_ON
			#pragma shader_feature_local _MOBILESHADINGWORLDUP_ON


			struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float3 previousPositionOS : TEXCOORD4;
				float3 precomputedVelocity : TEXCOORD5;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_Position;
				float3 positionRWS : TEXCOORD0;
				float3 normalWS : TEXCOORD1;
				float4 tangentWS : TEXCOORD2;
				float4 uv1 : TEXCOORD3;
				float4 uv2 : TEXCOORD4;
				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					float3 vpassPositionCS : TEXCOORD5;
					float3 vpassPreviousPositionCS : TEXCOORD6;
				#endif
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				#if defined(SHADER_STAGE_FRAGMENT) && defined(ASE_NEED_CULLFACE)
				FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
				#endif
			};

			float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }
			float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }
			float snoise( float2 v )
			{
				const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
				float2 i = floor( v + dot( v, C.yy ) );
				float2 x0 = v - i + dot( i, C.xx );
				float2 i1;
				i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
				float4 x12 = x0.xyxy + C.xxzz;
				x12.xy -= i1;
				i = mod2D289( i );
				float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
				float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
				m = m * m;
				m = m * m;
				float3 x = 2.0 * frac( p * C.www ) - 1.0;
				float3 h = abs( x ) - 0.5;
				float3 ox = floor( x + 0.5 );
				float3 a0 = x - ox;
				m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
				float3 g;
				g.x = a0.x * x0.x + h.x * x0.y;
				g.yz = a0.yz * x12.xz + h.yz * x12.yw;
				return 130.0 * dot( m, g );
			}
			
			inline float noise_randomValue (float2 uv) { return frac(sin(dot(uv, float2(12.9898, 78.233)))*43758.5453); }
			inline float noise_interpolate (float a, float b, float t) { return (1.0-t)*a + (t*b); }
			inline float valueNoise (float2 uv)
			{
				float2 i = floor(uv);
				float2 f = frac( uv );
				f = f* f * (3.0 - 2.0 * f);
				uv = abs( frac(uv) - 0.5);
				float2 c0 = i + float2( 0.0, 0.0 );
				float2 c1 = i + float2( 1.0, 0.0 );
				float2 c2 = i + float2( 0.0, 1.0 );
				float2 c3 = i + float2( 1.0, 1.0 );
				float r0 = noise_randomValue( c0 );
				float r1 = noise_randomValue( c1 );
				float r2 = noise_randomValue( c2 );
				float r3 = noise_randomValue( c3 );
				float bottomOfGrid = noise_interpolate( r0, r1, f.x );
				float topOfGrid = noise_interpolate( r2, r3, f.x );
				float t = noise_interpolate( bottomOfGrid, topOfGrid, f.y );
				return t;
			}
			
			float SimpleNoise(float2 UV)
			{
				float t = 0.0;
				float freq = pow( 2.0, float( 0 ) );
				float amp = pow( 0.5, float( 3 - 0 ) );
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(1));
				amp = pow(0.5, float(3-1));
				t += valueNoise( UV/freq )*amp;
				freq = pow(2.0, float(2));
				amp = pow(0.5, float(3-2));
				t += valueNoise( UV/freq )*amp;
				return t;
			}
			
			float3 RotateAroundAxis( float3 center, float3 original, float3 u, float angle )
			{
				original -= center;
				float C = cos( angle );
				float S = sin( angle );
				float t = 1 - C;
				float m00 = t * u.x * u.x + C;
				float m01 = t * u.x * u.y - S * u.z;
				float m02 = t * u.x * u.z + S * u.y;
				float m10 = t * u.x * u.y + S * u.z;
				float m11 = t * u.y * u.y + C;
				float m12 = t * u.y * u.z - S * u.x;
				float m20 = t * u.x * u.z - S * u.y;
				float m21 = t * u.y * u.z + S * u.x;
				float m22 = t * u.z * u.z + C;
				float3x3 finalMatrix = float3x3( m00, m01, m02, m10, m11, m12, m20, m21, m22 );
				return mul( finalMatrix, original ) + center;
			}
			

			// Get Surface And BuiltinData
			void GetSurfaceAndBuiltinData(PickingSurfaceDescription surfaceDescription, FragInputs fragInputs, float3 V, inout PositionInputs posInput, out SurfaceData surfaceData, out BuiltinData builtinData)
			{
				#ifdef LOD_FADE_CROSSFADE
                    LODDitheringTransition(ComputeFadeMaskSeed(V, posInput.positionSS), unity_LODFade.x);
				#endif

                #ifdef _DOUBLESIDED_ON
                    float3 doubleSidedConstants = _DoubleSidedConstants.xyz;
                #else
                    float3 doubleSidedConstants = float3(1.0, 1.0, 1.0);
                #endif  
                ApplyDoubleSidedFlipOrMirror(fragInputs, doubleSidedConstants);

				#ifdef _ALPHATEST_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThreshold );
				#endif

				#ifdef _ALPHATEST_SHADOW_ON
                    DoAlphaTest( surfaceDescription.Alpha, surfaceDescription.AlphaClipThresholdShadow);
				#endif

				#ifdef _DEPTHOFFSET_ON
                    ApplyDepthOffsetPositionInput(V, surfaceDescription.DepthOffset, GetViewForwardDir(), GetWorldToHClipMatrix(), posInput);
				#endif

				float3 bentNormalWS;
                //BuildSurfaceData(fragInputs, surfaceDescription, V, posInput, surfaceData, bentNormalWS);
                InitBuiltinData(posInput, surfaceDescription.Alpha, bentNormalWS, -fragInputs.tangentToWorld[2], fragInputs.texCoord1, fragInputs.texCoord2, builtinData);

				#ifdef _DEPTHOFFSET_ON
                    builtinData.depthOffset = surfaceDescription.DepthOffset;
				#endif

                #ifdef _ALPHATEST_ON
                    builtinData.alphaClipTreshold = surfaceDescription.AlphaClipThreshold;
                #endif

                #ifdef UNITY_VIRTUAL_TEXTURING
                    builtinData.vtPackedFeedback = surfaceDescription.VTPackedFeedback;
                #endif

				#ifdef ASE_BAKEDGI
                    builtinData.bakeDiffuseLighting = surfaceDescription.BakedGI;
				#endif

				#ifdef ASE_BAKEDBACKGI
                    builtinData.backBakeDiffuseLighting = surfaceDescription.BakedBackGI;
				#endif

                builtinData.emissiveColor = surfaceDescription.Emission;

				PostInitBuiltinData(V, posInput, surfaceData, builtinData);

            }

			AttributesMesh ApplyMeshModification(AttributesMesh inputMesh, float3 timeParameters, inout PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS )
			{
				_TimeParameters.xyz = timeParameters;
				float3 ase_worldPos = GetAbsolutePositionWS( TransformObjectToWorld( (inputMesh.positionOS).xyz ) );
				float3 normalizeResult710_g1592 = normalize( ase_worldPos );
				float mulTime716_g1592 = _TimeParameters.x * 0.25;
				float simplePerlin2D714_g1592 = snoise( ( normalizeResult710_g1592 + mulTime716_g1592 ).xy*0.43 );
				float WindMask_LargeB725_g1592 = ( simplePerlin2D714_g1592 * 1.5 );
				float3 appendResult820_g1592 = (float3(0.0 , 0.0 , saturate( inputMesh.positionOS ).z));
				float3 break862_g1592 = inputMesh.positionOS;
				float3 appendResult819_g1592 = (float3(break862_g1592.x , ( break862_g1592.y * 0.15 ) , 0.0));
				float mulTime849_g1592 = _TimeParameters.x * 2.1;
				float3 temp_output_573_0_g1592 = ( ( inputMesh.positionOS - float3(0,-1,0) ) / _Radius );
				float dotResult574_g1592 = dot( temp_output_573_0_g1592 , temp_output_573_0_g1592 );
				float temp_output_577_0_g1592 = pow( saturate( dotResult574_g1592 ) , _Hardness );
				float SphearicalMaskCM735_g1592 = saturate( temp_output_577_0_g1592 );
				float3 temp_cast_1 = (inputMesh.positionOS.y).xxx;
				float2 appendResult810_g1592 = (float2(inputMesh.positionOS.x , inputMesh.positionOS.z));
				float3 temp_output_869_0_g1592 = ( cross( temp_cast_1 , float3( appendResult810_g1592 ,  0.0 ) ) * 0.005 );
				float3 appendResult813_g1592 = (float3(0.0 , inputMesh.positionOS.y , 0.0));
				float3 break845_g1592 = inputMesh.positionOS;
				float3 appendResult843_g1592 = (float3(break845_g1592.x , 0.0 , ( break845_g1592.z * 0.15 )));
				float mulTime850_g1592 = _TimeParameters.x * 2.3;
				float dotResult730_g1592 = dot( (inputMesh.positionOS*0.02 + 0.0) , inputMesh.positionOS );
				float CeneterOfMassThickness_Mask734_g1592 = saturate( dotResult730_g1592 );
				float3 appendResult854_g1592 = (float3(inputMesh.positionOS.x , 0.0 , 0.0));
				float3 break857_g1592 = inputMesh.positionOS;
				float3 appendResult842_g1592 = (float3(0.0 , ( break857_g1592.y * 0.2 ) , ( break857_g1592.z * 0.4 )));
				float mulTime851_g1592 = _TimeParameters.x * 2.0;
				float3 normalizeResult1560_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP_C1561_g1592 = saturate( distance( normalizeResult1560_g1592 , float3(0,1,0) ) );
				float3 normalizeResult718_g1592 = normalize( ase_worldPos );
				float mulTime723_g1592 = _TimeParameters.x * 0.26;
				float simplePerlin2D722_g1592 = snoise( ( normalizeResult718_g1592 + mulTime723_g1592 ).xy*0.7 );
				float WindMask_LargeC726_g1592 = ( simplePerlin2D722_g1592 * 1.5 );
				float mulTime795_g1592 = _TimeParameters.x * 3.2;
				float3 worldToObj796_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_763_0_g1592 = ( mulTime795_g1592 + float3(0.4,0.3,0.1) + ( worldToObj796_g1592.x * 0.02 ) + ( 0.14 * worldToObj796_g1592.y ) + ( worldToObj796_g1592.z * 0.16 ) );
				float3 normalizeResult581_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMassTrunkUP586_g1592 = saturate( (distance( normalizeResult581_g1592 , float3(0,1,0) )*1.0 + -0.05) );
				float3 ase_objectScale = float3( length( GetObjectToWorldMatrix()[ 0 ].xyz ), length( GetObjectToWorldMatrix()[ 1 ].xyz ), length( GetObjectToWorldMatrix()[ 2 ].xyz ) );
				float mulTime794_g1592 = _TimeParameters.x * 2.3;
				float3 worldToObj797_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float3 temp_output_757_0_g1592 = ( mulTime794_g1592 + ( 0.2 * worldToObj797_g1592 ) + float3(0.4,0.3,0.1) );
				float mulTime793_g1592 = _TimeParameters.x * 3.6;
				float3 temp_cast_5 = (inputMesh.positionOS.x).xxx;
				float3 worldToObj799_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(temp_cast_5), 1 ) ).xyz;
				float temp_output_787_0_g1592 = ( mulTime793_g1592 + ( 0.2 * worldToObj799_g1592.x ) );
				float3 normalizeResult647_g1592 = normalize( inputMesh.positionOS );
				float CenterOfMass651_g1592 = saturate( (distance( normalizeResult647_g1592 , float3(0,1,0) )*2.0 + 0.0) );
				float SphericalMaskProxySphere655_g1592 = (( _CenterofMass )?( ( temp_output_577_0_g1592 * CenterOfMass651_g1592 ) ):( temp_output_577_0_g1592 ));
				float StrongWindSpeed994_g1592 = _StrongWindSpeed;
				float2 appendResult1379_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float3 worldToObj1380_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(float3( appendResult1379_g1592 ,  0.0 )), 1 ) ).xyz;
				float simpleNoise1430_g1592 = SimpleNoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + worldToObj1380_g1592 ).xy*4.0 );
				simpleNoise1430_g1592 = simpleNoise1430_g1592*2 - 1;
				float3 worldToObj1376_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1321_g1592 = _TimeParameters.x * 10.0;
				float3 temp_output_1316_0_g1592 = ( sin( ( ( worldToObj1376_g1592 * ( 1.0 * 10.0 * ase_objectScale ) ) + mulTime1321_g1592 + 1.0 ) ) * 0.028 );
				float3 MotionFlutterConstant1481_g1592 = ( temp_output_1316_0_g1592 * 33 );
				float4 temp_cast_12 = (inputMesh.ase_color.g).xxxx;
				float4 LeafVertexColor_Main1540_g1592 = (( _SwitchVGreenToRGBA )?( inputMesh.ase_color ):( temp_cast_12 ));
				float mulTime1349_g1592 = _TimeParameters.x * 0.4;
				float3 worldToObj1443_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.tangentOS.xyz), 1 ) ).xyz;
				float2 panner1354_g1592 = ( mulTime1349_g1592 * float2( 1,1 ) + ( worldToObj1443_g1592 * 0.1 ).xy);
				float2 texCoord1355_g1592 = inputMesh.ase_texcoord.xy * float2( 0.2,0.2 ) + panner1354_g1592;
				float3 normalizeResult589_g1592 = normalize( ase_worldPos );
				float mulTime590_g1592 = _TimeParameters.x * 0.2;
				float simplePerlin2D592_g1592 = snoise( ( normalizeResult589_g1592 + mulTime590_g1592 ).xy*0.4 );
				float WindMask_LargeA595_g1592 = ( simplePerlin2D592_g1592 * 1.5 );
				float3 worldToObjDir1435_g1592 = mul( GetWorldToObjectMatrix(), float4( ( tex2Dlod( _WindNoise, float4( texCoord1355_g1592, 0, 0.0) ) * WindMask_LargeA595_g1592 * WindMask_LargeC726_g1592 ).rgb, 0 ) ).xyz;
				float dotResult4_g1593 = dot( float2( 0.2,0.2 ) , float2( 12.9898,78.233 ) );
				float lerpResult10_g1593 = lerp( 0.0 , 0.35 , frac( ( sin( dotResult4_g1593 ) * 43758.55 ) ));
				float2 appendResult1454_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float simpleNoise1455_g1592 = SimpleNoise( ( appendResult1454_g1592 + ( StrongWindSpeed994_g1592 * _TimeParameters.x ) )*4.0 );
				simpleNoise1455_g1592 = simpleNoise1455_g1592*2 - 1;
				float simplePerlin2D1395_g1592 = snoise( ( ( StrongWindSpeed994_g1592 * _TimeParameters.x ) + ( inputMesh.tangentOS.xyz * 1.0 ) ).xy );
				#ifdef _LEAFFLUTTER_ON
				float4 staticSwitch1263_g1592 = ( ( ( ( simpleNoise1430_g1592 * 0.9 ) * float4( float3(-1,-0.5,-1) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * float4( MotionFlutterConstant1481_g1592 , 0.0 ) * WindMask_LargeC726_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( worldToObjDir1435_g1592 , 0.0 ) * float4( float3(-1,-1,-1) , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( ase_objectScale , 0.0 ) ) * 1 ) + ( ( float4( float3(-1,-1,-1) , 0.0 ) * lerpResult10_g1593 * simpleNoise1455_g1592 * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 * float4( inputMesh.tangentOS.xyz , 0.0 ) ) * 2 ) + ( ( simplePerlin2D1395_g1592 * 0.11 ) * float4( float3(5.9,5.9,5.9) , 0.0 ) * float4( inputMesh.tangentOS.xyz , 0.0 ) * saturate( inputMesh.positionOS.y ) * WindMask_LargeA595_g1592 * LeafVertexColor_Main1540_g1592 ) + ( ( float4( temp_output_1316_0_g1592 , 0.0 ) * saturate( inputMesh.positionOS.y ) * LeafVertexColor_Main1540_g1592 ) * 3 ) ) * _GlobalFlutterIntensity );
				#else
				float4 staticSwitch1263_g1592 = float4( 0,0,0,0 );
				#endif
				float3 worldToObj1580_g1592 = mul( GetWorldToObjectMatrix(), float4( GetCameraRelativePositionWS(inputMesh.positionOS), 1 ) ).xyz;
				float mulTime1587_g1592 = _TimeParameters.x * 4.0;
				float mulTime1579_g1592 = _TimeParameters.x * 0.2;
				float2 appendResult1576_g1592 = (float2(ase_worldPos.x , ase_worldPos.z));
				float2 normalizeResult1578_g1592 = normalize( appendResult1576_g1592 );
				float simpleNoise1588_g1592 = SimpleNoise( ( mulTime1579_g1592 + normalizeResult1578_g1592 )*1.0 );
				float WindMask_SimpleSway1593_g1592 = ( simpleNoise1588_g1592 * 1.5 );
				float3 rotatedValue1599_g1592 = RotateAroundAxis( float3( 0,0,0 ), inputMesh.positionOS, normalize( float3(0.6,1,0.1) ), ( ( cos( ( ( worldToObj1580_g1592 * 0.02 ) + mulTime1587_g1592 + ( float3(0.6,1,0.8) * 0.3 * worldToObj1580_g1592 ) ) ) * 0.1 ) * WindMask_SimpleSway1593_g1592 * saturate( ase_objectScale ) ).x );
				float4 temp_cast_30 = (0.0).xxxx;
				#if defined(_WINDTYPE_GENTLEBREEZE)
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#elif defined(_WINDTYPE_WINDOFF)
				float4 staticSwitch1496_g1592 = temp_cast_30;
				#else
				float4 staticSwitch1496_g1592 = ( ( float4( ( ( WindMask_LargeB725_g1592 * ( ( ( ( ( appendResult820_g1592 + ( appendResult819_g1592 * cos( mulTime849_g1592 ) ) + ( cross( float3(1.2,0.6,1) , ( float3(0.7,1,0.8) * appendResult819_g1592 ) ) * sin( mulTime849_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.08 ) + ( ( ( appendResult813_g1592 + ( appendResult843_g1592 * cos( mulTime850_g1592 ) ) + ( cross( float3(0.9,1,1.2) , ( float3(1,1,1) * appendResult843_g1592 ) ) * sin( mulTime850_g1592 ) ) ) * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * temp_output_869_0_g1592 ) * 0.1 ) + ( ( ( appendResult854_g1592 + ( appendResult842_g1592 * cos( mulTime851_g1592 ) ) + ( cross( float3(1.1,1.3,0.8) , ( float3(1.4,0.8,1.1) * appendResult842_g1592 ) ) * sin( mulTime851_g1592 ) ) ) * SphearicalMaskCM735_g1592 * temp_output_869_0_g1592 ) * 0.05 ) ) * _BranchWindLarge ) ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + float4( ( ( ( WindMask_LargeC726_g1592 * ( ( ( ( cos( temp_output_763_0_g1592 ) * sin( temp_output_763_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * SphearicalMaskCM735_g1592 * CeneterOfMassThickness_Mask734_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( cos( temp_output_757_0_g1592 ) * sin( temp_output_757_0_g1592 ) * CenterOfMassTrunkUP586_g1592 * CeneterOfMassThickness_Mask734_g1592 * SphearicalMaskCM735_g1592 * saturate( ase_objectScale ) ) * 0.2 ) + ( ( sin( temp_output_787_0_g1592 ) * cos( temp_output_787_0_g1592 ) * SphericalMaskProxySphere655_g1592 * CeneterOfMassThickness_Mask734_g1592 * CenterOfMassTrunkUP586_g1592 ) * 0.2 ) ) * _BranchWindSmall ) ) * 0.3 ) * CenterOfMassTrunkUP_C1561_g1592 ) , 0.0 ) + ( staticSwitch1263_g1592 * 0.3 ) + float4( (( _PivotSway )?( ( ( rotatedValue1599_g1592 - inputMesh.positionOS ) * 0.4 ) ):( float3( 0,0,0 ) )) , 0.0 ) ) * saturate( inputMesh.positionOS.y ) );
				#endif
				float4 FinalWind_Output163_g1592 = ( _GlobalWindStrength * staticSwitch1496_g1592 );
				
				#ifdef _MOBILESHADINGWORLDUP_ON
				float3 staticSwitch622_g1583 = float3(0,1,0);
				#else
				float3 staticSwitch622_g1583 = inputMesh.normalOS;
				#endif
				float3 LightDetect_Output597_g1583 = staticSwitch622_g1583;
				
				outputPackedVaryingsMeshToPS.ase_texcoord7.xy = inputMesh.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				outputPackedVaryingsMeshToPS.ase_texcoord7.zw = 0;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				float3 defaultVertexValue = inputMesh.positionOS.xyz;
				#else
				float3 defaultVertexValue = float3( 0, 0, 0 );
				#endif
				float3 vertexValue =  FinalWind_Output163_g1592.rgb;

				#ifdef ASE_ABSOLUTE_VERTEX_POS
				inputMesh.positionOS.xyz = vertexValue;
				#else
				inputMesh.positionOS.xyz += vertexValue;
				#endif
				inputMesh.normalOS = LightDetect_Output597_g1583;
				inputMesh.tangentOS = inputMesh.tangentOS;
				return inputMesh;
			}

			PackedVaryingsMeshToPS VertexFunction(AttributesMesh inputMesh)
			{
				PackedVaryingsMeshToPS outputPackedVaryingsMeshToPS = (PackedVaryingsMeshToPS)0;
				AttributesMesh defaultMesh = inputMesh;

				UNITY_SETUP_INSTANCE_ID(inputMesh);
				UNITY_TRANSFER_INSTANCE_ID(inputMesh, outputPackedVaryingsMeshToPS);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( outputPackedVaryingsMeshToPS );

				inputMesh = ApplyMeshModification( inputMesh, _TimeParameters.xyz, outputPackedVaryingsMeshToPS);

				float3 positionRWS = TransformObjectToWorld(inputMesh.positionOS);
				float3 normalWS = TransformObjectToWorldNormal(inputMesh.normalOS);
				float4 tangentWS = float4(TransformObjectToWorldDir(inputMesh.tangentOS.xyz), inputMesh.tangentOS.w);

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
				float4 VPASSpreviousPositionCS;
				float4 VPASSpositionCS = mul(UNITY_MATRIX_UNJITTERED_VP, float4(positionRWS, 1.0));

				bool forceNoMotion = unity_MotionVectorsParams.y == 0.0;
				if (forceNoMotion)
				{
					VPASSpreviousPositionCS = float4(0.0, 0.0, 0.0, 1.0);
				}
				else
				{
					bool hasDeformation = unity_MotionVectorsParams.x > 0.0;
					float3 effectivePositionOS = (hasDeformation ? inputMesh.previousPositionOS : defaultMesh.positionOS);
					#if defined(_ADD_PRECOMPUTED_VELOCITY)
					effectivePositionOS -= inputMesh.precomputedVelocity;
					#endif

					#if defined(HAVE_MESH_MODIFICATION)
						AttributesMesh previousMesh = defaultMesh;
						previousMesh.positionOS = effectivePositionOS ;
						PackedVaryingsMeshToPS test = (PackedVaryingsMeshToPS)0;
						float3 curTime = _TimeParameters.xyz;
						previousMesh = ApplyMeshModification(previousMesh, _LastTimeParameters.xyz, test);
						_TimeParameters.xyz = curTime;
						float3 previousPositionRWS = TransformPreviousObjectToWorld(previousMesh.positionOS);
					#else
						float3 previousPositionRWS = TransformPreviousObjectToWorld(effectivePositionOS);
					#endif

					#ifdef ATTRIBUTES_NEED_NORMAL
						float3 normalWS = TransformPreviousObjectToWorldNormal(defaultMesh.normalOS);
					#else
						float3 normalWS = float3(0.0, 0.0, 0.0);
					#endif

					#if defined(HAVE_VERTEX_MODIFICATION)
						ApplyVertexModification(inputMesh, normalWS, previousPositionRWS, _LastTimeParameters.xyz);
					#endif

					VPASSpreviousPositionCS = mul(UNITY_MATRIX_PREV_VP, float4(previousPositionRWS, 1.0));
				}
				#endif

				outputPackedVaryingsMeshToPS.positionCS = TransformWorldToHClip(positionRWS);
				outputPackedVaryingsMeshToPS.positionRWS.xyz = positionRWS;
				outputPackedVaryingsMeshToPS.normalWS.xyz = normalWS;
				outputPackedVaryingsMeshToPS.tangentWS.xyzw = tangentWS;
				outputPackedVaryingsMeshToPS.uv1.xyzw = inputMesh.uv1;
				outputPackedVaryingsMeshToPS.uv2.xyzw = inputMesh.uv2;

				#ifdef _WRITE_TRANSPARENT_MOTION_VECTOR
					outputPackedVaryingsMeshToPS.vpassPositionCS = float3(VPASSpositionCS.xyw);
					outputPackedVaryingsMeshToPS.vpassPreviousPositionCS = float3(VPASSpreviousPositionCS.xyw);
				#endif
				return outputPackedVaryingsMeshToPS;
			}

			#if defined(ASE_TESSELLATION)
			struct VertexControl
			{
				float3 positionOS : INTERNALTESSPOS;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				float4 ase_color : COLOR;
				float4 ase_texcoord : TEXCOORD0;

				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct TessellationFactors
			{
				float edge[3] : SV_TessFactor;
				float inside : SV_InsideTessFactor;
			};

			VertexControl Vert ( AttributesMesh v )
			{
				VertexControl o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				o.positionOS = v.positionOS;
				o.normalOS = v.normalOS;
				o.tangentOS = v.tangentOS;
				o.ase_color = v.ase_color;
				o.ase_texcoord = v.ase_texcoord;
				return o;
			}

			TessellationFactors TessellationFunction (InputPatch<VertexControl,3> v)
			{
				TessellationFactors o;
				float4 tf = 1;
				float tessValue = _TessValue; float tessMin = _TessMin; float tessMax = _TessMax;
				float edgeLength = _TessEdgeLength; float tessMaxDisp = _TessMaxDisp;
				#if (SHADEROPTIONS_CAMERA_RELATIVE_RENDERING != 0)
				float3 cameraPos = 0;
				#else
				float3 cameraPos = _WorldSpaceCameraPos;
				#endif
				#if defined(ASE_FIXED_TESSELLATION)
				tf = FixedTess( tessValue );
				#elif defined(ASE_DISTANCE_TESSELLATION)
				tf = DistanceBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), tessValue, tessMin, tessMax, GetObjectToWorldMatrix(), cameraPos );
				#elif defined(ASE_LENGTH_TESSELLATION)
				tf = EdgeLengthBasedTess(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, GetObjectToWorldMatrix(), cameraPos, _ScreenParams );
				#elif defined(ASE_LENGTH_CULL_TESSELLATION)
				tf = EdgeLengthBasedTessCull(float4(v[0].positionOS,1), float4(v[1].positionOS,1), float4(v[2].positionOS,1), edgeLength, tessMaxDisp, GetObjectToWorldMatrix(), cameraPos, _ScreenParams, _FrustumPlanes );
				#endif
				o.edge[0] = tf.x; o.edge[1] = tf.y; o.edge[2] = tf.z; o.inside = tf.w;
				return o;
			}

			[domain("tri")]
			[partitioning("fractional_odd")]
			[outputtopology("triangle_cw")]
			[patchconstantfunc("TessellationFunction")]
			[outputcontrolpoints(3)]
			VertexControl HullFunction(InputPatch<VertexControl, 3> patch, uint id : SV_OutputControlPointID)
			{
			   return patch[id];
			}

			[domain("tri")]
			PackedVaryingsMeshToPS DomainFunction(TessellationFactors factors, OutputPatch<VertexControl, 3> patch, float3 bary : SV_DomainLocation)
			{
				AttributesMesh o = (AttributesMesh) 0;
				o.positionOS = patch[0].positionOS * bary.x + patch[1].positionOS * bary.y + patch[2].positionOS * bary.z;
				o.normalOS = patch[0].normalOS * bary.x + patch[1].normalOS * bary.y + patch[2].normalOS * bary.z;
				o.tangentOS = patch[0].tangentOS * bary.x + patch[1].tangentOS * bary.y + patch[2].tangentOS * bary.z;
				o.ase_color = patch[0].ase_color * bary.x + patch[1].ase_color * bary.y + patch[2].ase_color * bary.z;
				o.ase_texcoord = patch[0].ase_texcoord * bary.x + patch[1].ase_texcoord * bary.y + patch[2].ase_texcoord * bary.z;
				#if defined(ASE_PHONG_TESSELLATION)
				float3 pp[3];
				for (int i = 0; i < 3; ++i)
					pp[i] = o.positionOS.xyz - patch[i].normalOS * (dot(o.positionOS.xyz, patch[i].normalOS) - dot(patch[i].positionOS.xyz, patch[i].normalOS));
				float phongStrength = _TessPhongStrength;
				o.positionOS.xyz = phongStrength * (pp[0]*bary.x + pp[1]*bary.y + pp[2]*bary.z) + (1.0f-phongStrength) * o.positionOS.xyz;
				#endif
				UNITY_TRANSFER_INSTANCE_ID(patch[0], o);
				return VertexFunction(o);
			}
			#else
			PackedVaryingsMeshToPS Vert ( AttributesMesh v )
			{
				return VertexFunction( v );
			}
			#endif

			#if defined(WRITE_NORMAL_BUFFER) && defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target2
			#elif defined(WRITE_NORMAL_BUFFER) || defined(WRITE_MSAA_DEPTH)
			#define SV_TARGET_DECAL SV_Target1
			#else
			#define SV_TARGET_DECAL SV_Target0
			#endif

			void Frag( PackedVaryingsMeshToPS packedInput
						#if defined(SCENESELECTIONPASS) || defined(SCENEPICKINGPASS)
						, out float4 outColor : SV_Target0
						#else
							#ifdef WRITE_MSAA_DEPTH
							, out float4 depthColor : SV_Target0
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target1
								#endif
							#else
								#ifdef WRITE_NORMAL_BUFFER
								, out float4 outNormalBuffer : SV_Target0
								#endif
							#endif

							#if defined(WRITE_DECAL_BUFFER) && !defined(_DISABLE_DECALS)
							, out float4 outDecalBuffer : SV_TARGET_DECAL
							#endif
						#endif

						#if defined(_DEPTHOFFSET_ON) && !defined(SCENEPICKINGPASS)
						, out float outputDepth : DEPTH_OFFSET_SEMANTIC
						#endif
						
					)
			{
			UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
			UNITY_SETUP_INSTANCE_ID(packedInput);

				float3 positionRWS = packedInput.positionRWS.xyz;

				FragInputs input;
				ZERO_INITIALIZE(FragInputs, input);

				input.tangentToWorld = k_identity3x3;
				input.positionSS = packedInput.positionCS;

				input.positionRWS = positionRWS;

				#if _DOUBLESIDED_ON && SHADER_STAGE_FRAGMENT
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false);
				#elif SHADER_STAGE_FRAGMENT
				#if defined(ASE_NEED_CULLFACE)
				input.isFrontFace = IS_FRONT_VFACE( packedInput.cullFace, true, false );
				#endif
				#endif
				half isFrontFace = input.isFrontFace;

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS);

				float3 V = GetWorldSpaceNormalizeViewDir(input.positionRWS);

				PickingSurfaceDescription surfaceDescription = (PickingSurfaceDescription)0;
				float2 uv_AlbedoMap555_g1583 = packedInput.ase_texcoord7.xy;
				float Opacity_Output559_g1583 = tex2D( _AlbedoMap, uv_AlbedoMap555_g1583 ).a;
				
				surfaceDescription.Alpha = Opacity_Output559_g1583;

				#ifdef _ALPHATEST_ON
				surfaceDescription.AlphaClipThreshold =  _AlphaCutoff;
				#endif

				outColor = _SelectionID;
			}

            ENDHLSL
		}

        Pass
        {

            Name "FullScreenDebug"
            Tags 
			{ 
				"LightMode" = "FullScreenDebug" 
            }

            Cull [_CullMode]
			ZTest LEqual
			ZWrite Off

            HLSLPROGRAM
			/*ase_pragma_before*/
			#pragma multi_compile_instancing
			#pragma instancing_options renderinglayer
            #pragma multi_compile _ DOTS_INSTANCING_ON

			#pragma vertex Vert
			#pragma fragment Frag

            #pragma shader_feature _ _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local _ _TRANSPARENT_WRITES_MOTION_VEC
            #pragma shader_feature_local_fragment _ _ENABLE_FOG_ON_TRANSPARENT

			#define SHADERPASS SHADERPASS_FULL_SCREEN_DEBUG

			#define ATTRIBUTES_NEED_NORMAL
			#define ATTRIBUTES_NEED_TANGENT

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Common.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/GeometricTools.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Tessellation.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderVariables.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/ShaderPass.cs.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
            #include "Packages/com.unity.shadergraph/ShaderGraphLibrary/Functions.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/FragInputs.hlsl"

			#ifndef SHADER_UNLIT
			#if defined(_DOUBLESIDED_ON) && !defined(VARYINGS_NEED_CULLFACE)
			#define VARYINGS_NEED_CULLFACE
			#endif
			#endif

		    #if defined(_MATERIAL_FEATURE_SUBSURFACE_SCATTERING) && !defined(_SURFACE_TYPE_TRANSPARENT)
		    #define OUTPUT_SPLIT_LIGHTING
		    #endif

            #if (SHADERPASS == SHADERPASS_PATH_TRACING) && !defined(_DOUBLESIDED_ON) && (defined(_REFRACTION_PLANE) || defined(_REFRACTION_SPHERE))
            #undef  _REFRACTION_PLANE
            #undef  _REFRACTION_SPHERE
            #define _REFRACTION_THIN
            #endif

			#if SHADERPASS == SHADERPASS_TRANSPARENT_DEPTH_PREPASS
			#if !defined(_DISABLE_SSR_TRANSPARENT) && !defined(SHADER_UNLIT)
				#define WRITE_NORMAL_BUFFER
			#endif
			#endif

			#ifndef DEBUG_DISPLAY
				#if !defined(_SURFACE_TYPE_TRANSPARENT)
					#if SHADERPASS == SHADERPASS_FORWARD
					#define SHADERPASS_FORWARD_BYPASS_ALPHA_TEST
					#elif SHADERPASS == SHADERPASS_GBUFFER
					#define SHADERPASS_GBUFFER_BYPASS_ALPHA_TEST
					#endif
				#endif
			#endif

            #if defined(SHADER_LIT) && !defined(_SURFACE_TYPE_TRANSPARENT)
                #define _DEFERRED_CAPABLE_MATERIAL
            #endif
        
            #if defined(_TRANSPARENT_WRITES_MOTION_VEC) && defined(_SURFACE_TYPE_TRANSPARENT)
                #define _WRITE_TRANSPARENT_MOTION_VECTOR
            #endif

            #ifdef DEBUG_DISPLAY
            #include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
            #endif

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Material.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/NormalSurfaceGradient.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/Lit/Lit.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/BuiltinUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Material/MaterialUtilities.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/ShaderLibrary/ShaderGraphFunctions.hlsl"

            struct AttributesMesh
			{
				float3 positionOS : POSITION;
				float3 normalOS : NORMAL;
				float4 tangentOS : TANGENT;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : INSTANCEID_SEMANTIC;
				#endif
			};

			struct VaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

			struct VertexDescriptionInputs
			{
				 float3 ObjectSpaceNormal;
				 float3 ObjectSpaceTangent;
				 float3 ObjectSpacePosition;
			};

			struct SurfaceDescriptionInputs
			{
				 float3 TangentSpaceNormal;
			};

			struct PackedVaryingsMeshToPS
			{
				SV_POSITION_QUALIFIERS float4 positionCS : SV_POSITION;
				#if UNITY_ANY_INSTANCING_ENABLED
					uint instanceID : CUSTOM_INSTANCE_ID;
				#endif
			};

            PackedVaryingsMeshToPS PackVaryingsMeshToPS (VaryingsMeshToPS input)
			{
				PackedVaryingsMeshToPS output;
				ZERO_INITIALIZE(PackedVaryingsMeshToPS, output);
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

			VaryingsMeshToPS UnpackVaryingsMeshToPS (PackedVaryingsMeshToPS input)
			{
				VaryingsMeshToPS output;
				output.positionCS = input.positionCS;
				#if UNITY_ANY_INSTANCING_ENABLED
				output.instanceID = input.instanceID;
				#endif
				return output;
			}

            struct VertexDescription
			{
				float3 Position;
				float3 Normal;
				float3 Tangent;
			};

			VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
			{
				VertexDescription description = (VertexDescription)0;
				description.Position = IN.ObjectSpacePosition;
				description.Normal = IN.ObjectSpaceNormal;
				description.Tangent = IN.ObjectSpaceTangent;
				return description;
			}

            struct SurfaceDescription
			{
				float3 BaseColor;
				float3 Emission;
				float Alpha;
				float3 BentNormal;
				float Smoothness;
				float Occlusion;
				float3 NormalTS;
				float Metallic;
			};

			SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
			{
				SurfaceDescription surface = (SurfaceDescription)0;
				surface.BaseColor = IsGammaSpace() ? float3(0.5, 0.5, 0.5) : SRGBToLinear(float3(0.5, 0.5, 0.5));
				surface.Emission = float3(0, 0, 0);
				surface.Alpha = 1;
				surface.BentNormal = IN.TangentSpaceNormal;
				surface.Smoothness = 0.5;
				surface.Occlusion = 1;
				surface.NormalTS = IN.TangentSpaceNormal;
				surface.Metallic = 0;
				return surface;
			}

			VertexDescriptionInputs AttributesMeshToVertexDescriptionInputs(AttributesMesh input)
			{
				VertexDescriptionInputs output;
				ZERO_INITIALIZE(VertexDescriptionInputs, output);

				output.ObjectSpaceNormal =                          input.normalOS;
				output.ObjectSpaceTangent =                         input.tangentOS.xyz;
				output.ObjectSpacePosition =                        input.positionOS;

				return output;
			}

			AttributesMesh ApplyMeshModification(AttributesMesh input, float3 timeParameters  )
			{
				VertexDescriptionInputs vertexDescriptionInputs = AttributesMeshToVertexDescriptionInputs(input);

				VertexDescription vertexDescription = VertexDescriptionFunction(vertexDescriptionInputs);

				input.positionOS = vertexDescription.Position;
				input.normalOS = vertexDescription.Normal;
				input.tangentOS.xyz = vertexDescription.Tangent;
				return input;
			}

			FragInputs BuildFragInputs(VaryingsMeshToPS input)
			{
				FragInputs output;
				ZERO_INITIALIZE(FragInputs, output);

				output.tangentToWorld = k_identity3x3;
				output.positionSS = input.positionCS; // input.positionCS is SV_Position

				return output;
			}

			FragInputs UnpackVaryingsMeshToFragInputs(PackedVaryingsMeshToPS input)
			{
				UNITY_SETUP_INSTANCE_ID(input);
				VaryingsMeshToPS unpacked = UnpackVaryingsMeshToPS(input);
				return BuildFragInputs(unpacked);
			}

			#define DEBUG_DISPLAY
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/DebugDisplay.hlsl"
			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/Debug/FullScreenDebug.hlsl"

			#include "Packages/com.unity.render-pipelines.high-definition/Runtime/RenderPipeline/ShaderPass/VertMesh.hlsl"

			PackedVaryingsType Vert(AttributesMesh inputMesh)
			{
				VaryingsType varyingsType;
				varyingsType.vmesh = VertMesh(inputMesh);
				return PackVaryingsType(varyingsType);
			}

			#if !defined(_DEPTHOFFSET_ON)
			[earlydepthstencil]
			#endif
			void Frag(PackedVaryingsToPS packedInput)
			{
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(packedInput);
				FragInputs input = UnpackVaryingsToFragInputs(packedInput);

				PositionInputs posInput = GetPositionInput(input.positionSS.xy, _ScreenSize.zw, input.positionSS.z, input.positionSS.w, input.positionRWS.xyz);

			#ifdef PLATFORM_SUPPORTS_PRIMITIVE_ID_IN_PIXEL_SHADER
				if (_DebugFullScreenMode == FULLSCREENDEBUGMODE_QUAD_OVERDRAW)
				{
					IncrementQuadOverdrawCounter(posInput.positionSS.xy, input.primitiveID);
				}
			#endif
			}
            ENDHLSL
        }
		
	}
	
	CustomEditor "Rendering.HighDefinition.LightingShaderGraphGUI"
	
	Fallback Off
}
/*ASEBEGIN
Version=19303
Node;AmplifyShaderEditor.CommentaryNode;2911;816,624;Inherit;False;451.0001;235;Occludes SSS in shadow.;2;2874;2873;Fix Translucency Shadow;1,1,1,1;0;0
Node;AmplifyShaderEditor.BakedGINode;2874;864,672;Inherit;False;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2873;1088,720;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DiffusionProfileNode;2870;944,368;Float;False;Property;_DiffusionProfile;Diffusion Profile;39;0;Create;True;0;0;0;False;0;False;fd758c9e27d8d784980e86ac31c1676f;fd758c9e27d8d784980e86ac31c1676f;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;2921;912,112;Inherit;False;(TTFE) Tree Foliage_Shading;0;;1583;32f9493bbb6c2d44ab3d59bde623860f;0;0;7;COLOR;152;FLOAT3;153;FLOAT;27;FLOAT;25;FLOAT;26;FLOAT3;28;FLOAT;794
Node;AmplifyShaderEditor.FunctionNode;2925;896,464;Inherit;False;(TTFE) Tree Foliage_Wind System;25;;1592;ccec0b38fced125459cc01da4402fa7a;0;0;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;2926;1312,688;Inherit;False;Property;_BakedGIONOFF;Baked GI ON/OFF;24;0;Create;True;0;0;0;False;0;False;0;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2842;1338.528,120.0737;Float;False;True;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;12;Toby Fredson/The Toby Foliage Engine/(TTFE) Tree Foliage;53b46d85872c5b24c8f4f0a1c3fe4c87;True;GBuffer;0;0;GBuffer;34;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;True;True;True;True;0;True;_LightLayersMaskBuffer4;False;False;False;False;False;False;False;True;True;0;True;_StencilRefGBuffer;255;False;;255;True;_StencilWriteMaskGBuffer;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;False;True;0;True;_ZTestGBuffer;False;True;1;LightMode=GBuffer;False;False;0;;0;0;Standard;38;Surface Type;0;0;  Rendering Pass;1;0;  Refraction Model;0;0;    Blending Mode;0;0;    Blend Preserves Specular;1;0;  Back Then Front Rendering;0;0;  Transparent Depth Prepass;0;0;  Transparent Depth Postpass;0;0;  ZWrite;0;0;  Z Test;4;0;Double-Sided;1;638455099285396543;Alpha Clipping;1;638455101873073633;  Use Shadow Threshold;0;0;Material Type,InvertActionOnDeselection;5;638455793490320483;  Energy Conserving Specular;1;0;  Transmission,InvertActionOnDeselection;0;0;Receive Decals;0;638455099692093303;Receive SSR;1;0;Receive SSR Transparent;0;0;Motion Vectors;0;638455104269821093;  Add Precomputed Velocity;0;0;Specular AA;0;638455793410837054;Specular Occlusion Mode;1;0;Override Baked GI;1;638455810838973287;Depth Offset;0;0;  Conserative;1;0;GPU Instancing;1;0;LOD CrossFade;1;638455129832813018;Tessellation;0;0;  Phong;0;0;  Strength;0.5,False,;0;  Type;0;0;  Tess;16,False,;0;  Min;10,False,;0;  Max;25,False,;0;  Edge Length;16,False,;0;  Max Displacement;25,False,;0;Vertex Position;1;0;0;11;True;True;True;True;True;False;False;False;False;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2843;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;META;0;1;META;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2844;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;ShadowCaster;0;2;ShadowCaster;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;True;3;False;;False;True;1;LightMode=ShadowCaster;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2845;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;SceneSelectionPass;0;3;SceneSelectionPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=SceneSelectionPass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2846;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;DepthOnly;0;4;DepthOnly;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=DepthOnly;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2847;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;MotionVectors;0;5;MotionVectors;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefMV;255;False;;255;True;_StencilWriteMaskMV;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=MotionVectors;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2848;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentBackface;0;6;TransparentBackface;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelOne;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelTwo;False;False;False;False;False;True;0;True;_ZWrite;True;0;True;_ZTestTransparent;False;True;1;LightMode=TransparentBackface;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2849;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentDepthPrepass;0;7;TransparentDepthPrepass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;True;True;0;True;_StencilRefDepth;255;False;;255;True;_StencilWriteMaskDepth;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;1;False;;False;False;True;1;LightMode=TransparentDepthPrepass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2850;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;TransparentDepthPostpass;0;8;TransparentDepthPostpass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;True;1;False;;False;False;True;1;LightMode=TransparentDepthPostpass;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2851;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;Forward;0;9;Forward;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;True;2;5;False;;10;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;True;0;True;_CullModeForward;False;False;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelOne;False;True;True;True;True;True;0;True;_ColorMaskTransparentVelTwo;False;False;False;True;True;0;True;_StencilRef;255;False;;255;True;_StencilWriteMask;7;False;;3;False;;0;False;;0;False;;7;False;;3;False;;0;False;;0;False;;False;True;0;True;_ZWrite;True;0;True;_ZTestDepthEqualForOpaque;False;True;1;LightMode=Forward;False;False;0;;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;2852;1338.528,120.0737;Float;False;False;-1;2;Rendering.HighDefinition.LightingShaderGraphGUI;0;1;New Amplify Shader;53b46d85872c5b24c8f4f0a1c3fe4c87;True;ScenePickingPass;0;10;ScenePickingPass;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;3;RenderPipeline=HDRenderPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;True;5;True;7;d3d11;metal;vulkan;xboxone;xboxseries;playstation;switch;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;0;True;_CullMode;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;True;3;False;;False;True;1;LightMode=Picking;False;False;0;;0;0;Standard;0;False;0
WireConnection;2873;1;2874;0
WireConnection;2926;1;2873;0
WireConnection;2842;0;2921;152
WireConnection;2842;1;2921;153
WireConnection;2842;7;2921;27
WireConnection;2842;8;2921;25
WireConnection;2842;9;2921;26
WireConnection;2842;16;2921;794
WireConnection;2842;62;2870;0
WireConnection;2842;31;2926;0
WireConnection;2842;32;2873;0
WireConnection;2842;11;2925;0
WireConnection;2842;12;2921;28
ASEEND*/
//CHKSM=CEE1F384A8234A757F592FE315FDFB2946811D9A