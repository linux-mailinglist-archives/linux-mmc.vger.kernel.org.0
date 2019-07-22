Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 380C86FA38
	for <lists+linux-mmc@lfdr.de>; Mon, 22 Jul 2019 09:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfGVHXU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 22 Jul 2019 03:23:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36446 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGVHXU (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2019 03:23:20 -0400
Received: by mail-wm1-f68.google.com with SMTP id g67so30075987wme.1
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2019 00:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LD9GCw1eG9QEzwE6oFNEQIzVZACLaoYqLB+k/zbJCdM=;
        b=F74SsFtcbnsipPjtAFo3nZeUH6oXlGCJDRP0xnmIpynir4g/z65Znh/Rxdd2tc3lki
         wx0RAIVfTJIsG7ZTIfRtu2bdYa+BCBHz3OVhl8COPy1j3OnmhfseibhuazJJnFwc4sMn
         PLrUS0kTR6HsNoSyBW3EEOG4Pfl0FhLObowRIh1kbW+zfjWnouJe1brgMeHF/LWG+Ncr
         NHoZ233iLFrxLCi//oLTNEjrGvo+2+wva77zg9rRZjTwCqO2VULUGR53ys5IKvj31ey9
         mdRsjJpQ8bQsS7Sc80nE9tMeweKFjVNI19QKv9GeLPDowm9rs3BZRoBwRngv6pEh3p4t
         2g5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LD9GCw1eG9QEzwE6oFNEQIzVZACLaoYqLB+k/zbJCdM=;
        b=R5wkdjKe1opkLHN9snUzvhHf+vJq/CDX8vCbJ5jn5NvOJqlst6XP6zKodnMTv30XNd
         oHJtX0l+w97IkIQbsotPoRi0pgpxRt8mXMVLVa96BaZCJzZr9bHytbpmRw3j3y14PV+j
         QSP2J8TCc+irQCVKNO8qpQpmmd9e/ID0aWERXkXc1Iy+3PT/otH8odrLDcFNG1Kv2muL
         4Au3gdXMaXkxT/OwFuWF7f8E5gWLVouByYSPDKYXYsJnVcHCCYlc1x8tkBpbtMg6SK8v
         273AYrkGXPr1oFv55sw9CP9++N582JREU6D1XrCzPwpshhWAkxY8t/09vbUWelGl6SeA
         YW9w==
X-Gm-Message-State: APjAAAWFXkcTtwsmPONTjHkym5T3qIkdpYrcwkdJuP+yGrXOYof6TrGM
        pmNGgQaiFKnO3C+G21IT8GXSZA==
X-Google-Smtp-Source: APXvYqzfS7FtcRA+07esTVYwytBlm7aKVdZY4D+n+4hAm1mqPLE6MFCdAZwiJjT7e6DFVVuG48UgJg==
X-Received: by 2002:a1c:7f57:: with SMTP id a84mr60819167wmd.3.1563780197608;
        Mon, 22 Jul 2019 00:23:17 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id s10sm50309877wmf.8.2019.07.22.00.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 00:23:17 -0700 (PDT)
Subject: Re: [PATCH 06/12] mmc: meson-mx-sdio: Fix misuse of GENMASK macro
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <cover.1562734889.git.joe@perches.com>
 <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <abf1a3b1-d221-6ad5-bdd1-98d7d1eefe83@baylibre.com>
Date:   Mon, 22 Jul 2019 09:23:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <94dcbeb13b08a67ae9f404aa590c1c1459bc5287.1562734889.git.joe@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/07/2019 07:04, Joe Perches wrote:
> Arguments are supposed to be ordered high then low.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/mmc/host/meson-mx-sdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
> index 2d736e416775..ba9a63db73da 100644
> --- a/drivers/mmc/host/meson-mx-sdio.c
> +++ b/drivers/mmc/host/meson-mx-sdio.c
> @@ -73,7 +73,7 @@
>  	#define MESON_MX_SDIO_IRQC_IF_CONFIG_MASK		GENMASK(7, 6)
>  	#define MESON_MX_SDIO_IRQC_FORCE_DATA_CLK		BIT(8)
>  	#define MESON_MX_SDIO_IRQC_FORCE_DATA_CMD		BIT(9)
> -	#define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK		GENMASK(10, 13)
> +	#define MESON_MX_SDIO_IRQC_FORCE_DATA_DAT_MASK		GENMASK(13, 10)
>  	#define MESON_MX_SDIO_IRQC_SOFT_RESET			BIT(15)
>  	#define MESON_MX_SDIO_IRQC_FORCE_HALT			BIT(30)
>  	#define MESON_MX_SDIO_IRQC_HALT_HOLE			BIT(31)
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
