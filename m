Return-Path: <linux-mmc+bounces-403-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0390D80B2E3
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 08:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D4F11F21250
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A5C5671;
	Sat,  9 Dec 2023 07:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h7s1bLBj"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F610D9
	for <linux-mmc@vger.kernel.org>; Fri,  8 Dec 2023 23:52:53 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54cd2281ccbso3666634a12.2
        for <linux-mmc@vger.kernel.org>; Fri, 08 Dec 2023 23:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702108372; x=1702713172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OF1zJ7Af2v9xDU7hNVguCKUVdPXqGW4Rh+0MbMHeaWo=;
        b=h7s1bLBjKVW3a6H0qTgAZQE05hSFYjU3b/NgcmYOXs6Mf8P1affmCs6Sb9Ics6kvUJ
         jN7j87I4hDkTYJ8jDhdcDpGRU3il6EvVsaaGNG67kEMJEl2dp8aL4AoEPQWUVsm1Wjq3
         L8kYdUR8qrf96L//+Wq1tK8fNkV0kP+EQveXAPllpaXBf9nkYXoFAtNTaIFrp6jsz+Ge
         vcxx77iSPriSGInBuh17ks2OXRszV07tRpm20jdt48CiLwDAc7z3MPRhrr1+spB/wHkW
         i1lBF9jywd3LxvZwTCCOkRJNyK0sNHfXaDDPiv6xNibnmHIDhgwWRxDGLTdJk2LKLf5R
         eEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702108372; x=1702713172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF1zJ7Af2v9xDU7hNVguCKUVdPXqGW4Rh+0MbMHeaWo=;
        b=jKceflLX0hSTUjgZvG3BiY9SdnJKwT2yqxX61c6rIa7j+PEKZCeTYv4NIQu6XhC19l
         IE4QtNAi+3D7uXkvXdK9QMpdWuoqlNLB3uRRn0r/UlG9LRfJPvXdhPTZqZitr5Ilgh17
         +9IPp1dK8QlAeq12Ks1HrRlBbEYWcL4AfLDFOsphoiOlHSJnPyeD8qH8p9QpyxmCrdgV
         G6IO9ZYMG4LdveyufWydhRA6BJGqFnJOrwrIrefXYU/yQdCtJksM2tbjnGovjaj6s6Ms
         Or0bsaRW2ASQL8aaqmE1rEgItt1c7tOrhUGXLAF9sCVP2zE9QyIYn2Gbo6B3ElteDtWv
         XJhA==
X-Gm-Message-State: AOJu0Yyhs7d7jRsYNOoLAXfsl6T4L7k4+KGx8Wp6IqHQUbfzbL1tQqoc
	kFwLSeT7fZT3ggKqrfSJ0vc/OA==
X-Google-Smtp-Source: AGHT+IGBUtxEoc4Mfw8vpUpmRu+AU75E7WPox/Mvk5utV2MwIPA1AHgAS/sVKuv44BNPXDuKuZGxLQ==
X-Received: by 2002:a50:a6ce:0:b0:54c:65c9:287 with SMTP id f14-20020a50a6ce000000b0054c65c90287mr669044edc.27.1702108372197;
        Fri, 08 Dec 2023 23:52:52 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id b42-20020a509f2d000000b0054cc6be8b0bsm1522876edf.32.2023.12.08.23.52.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 23:52:51 -0800 (PST)
Message-ID: <15edf785-3fab-4c0e-a96a-9753c3446370@linaro.org>
Date: Sat, 9 Dec 2023 08:52:49 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [V2, 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for
 74165b0
To: Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
 linux-kernel@vger.kernel.org, alcooperx@gmail.com,
 linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
 linux-mmc@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 Kamal Dasu <kdasu@broadcom.com>
References: <20231208210230.8191-1-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231208210230.8191-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/12/2023 22:02, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> With newer sdio controller core used for 74165b0 we need to update
> the compatibility with "brcm,bcm74165b0-sdhci".
> 
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index c028039bc477..178d47ed65ca 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -13,6 +13,10 @@ maintainers:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm74165b0-sdhci

If this is enum, then it should be combined with other enums like that.
Someone already duplicated this once, so don't make it third time. One
enum for all your variants with the same fallback.

Best regards,
Krzysztof


