// Infinitra © 2024 by Richard Bogad is licensed under CC BY-NC-SA 4.0.
// To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/4.0/

using System;
using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class CanvasFadeOut : MonoBehaviour
{

    public float fadeOutDuration = 5.0f;
    private CanvasGroup canvasGroup;

    public void Awake()
    {
        canvasGroup = GetComponent<CanvasGroup>();
    }

    public void TriggerFadeOut()
    {
        StartCoroutine(FadeOut());
    }

    private IEnumerator FadeOut()
    {
        float currentTime = 0.0f;

        while (currentTime < fadeOutDuration)
        {
            float alpha = Mathf.Lerp(1.0f, 0.0f, currentTime / fadeOutDuration);
            canvasGroup.alpha = alpha;
            currentTime += Time.deltaTime;
            yield return null;
        }

        canvasGroup.alpha = 0.0f;
        
        yield return null;
    }
}