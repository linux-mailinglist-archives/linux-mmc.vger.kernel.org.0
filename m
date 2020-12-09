Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D271B2D372E
	for <lists+linux-mmc@lfdr.de>; Wed,  9 Dec 2020 00:54:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgLHXxH (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 8 Dec 2020 18:53:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgLHXxG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Dec 2020 18:53:06 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4A3C061793
        for <linux-mmc@vger.kernel.org>; Tue,  8 Dec 2020 15:52:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id y10so156993plr.10
        for <linux-mmc@vger.kernel.org>; Tue, 08 Dec 2020 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NvXB67I/5HB464qBhYosURhxdymxqsfPHkIkuYm51kU=;
        b=FmgkzvTXfVDb6UTptSSvxlnKItvopLkj4ekZbM9jsYrbtHdZnRUee4R+RVAvIjTH5G
         mR5wu3gXenymZMRI/t/V9WVdrMV7dR3L6wGsEKTg3Sn4+risSbi/nKtsejsVIjwfkqF6
         1GJpN91TJx8S5RwRP0uHPu9Scn21facBivUNCZ3qJDGTWtMRziT3QD16q4XuhArYO2Pf
         boIGWKh2Eizwjc0cxDryxUiubEHVebPNvj0nT6F3mbdpEejD3ku99q7Jl1ubgo/Cqg2K
         QSKHSffAD4TGx33E6832qhS74yPqBLoj9O82FMMw0n5A4LMZKoNePXItIVOH0eNYBslD
         UWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NvXB67I/5HB464qBhYosURhxdymxqsfPHkIkuYm51kU=;
        b=jVy5f/P8l0FvJKzL0pEcpPoK1Qjx4vquklLQVyqL+e4FmF2aoEaoCgrDLSSTAJsSqa
         ixvPoAWPZz4DIppPIvfIfu/fypmA+LByt0GVkCgp2lbOddSdk+sGweovUa9Z4DSphqOw
         3S5uMIgTzqY7H5Mryqe4IUewipiLYbU9wKpy5aBivfrHwvtnDHr+dv10zihmANVBMkcR
         dmD3H/Wn6rB1S8WXVIon07y+hlY5e5/qSWd10SBtlEoBNh5Iyr+sso0PsDZF1hsJDrAn
         deSyu8HScQgv0ylH0cyhAC/iw460ZEaTeDCZ6k7xfFT6bNL2EyYRxqhQkNy3nZvDgBfG
         hFow==
X-Gm-Message-State: AOAM531pquNcG3P+fSAQwxqohLWqapv8G3AGOuARa1Eogwjy98s8l983
        OnZxxSAM+OmV89sYkT05YZq7SA==
X-Google-Smtp-Source: ABdhPJzC+yCY7+BiLq1RdqcahlR/A7QmKJzy/YznVOjrwgwDpH06sLZDmmKlxECrDl6a854d0TJD5g==
X-Received: by 2002:a17:902:b7c3:b029:da:76bc:2aa9 with SMTP id v3-20020a170902b7c3b02900da76bc2aa9mr401474plz.21.1607471546026;
        Tue, 08 Dec 2020 15:52:26 -0800 (PST)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id c13sm286543pfp.147.2020.12.08.15.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 15:52:25 -0800 (PST)
Date:   Tue, 8 Dec 2020 23:52:21 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Neeraj Soni <neersoni@codeaurora.org>,
        Barani Muthukumaran <bmuthuku@codeaurora.org>,
        Peng Zhou <peng.zhou@mediatek.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Konrad Dybcio <konradybcio@gmail.com>
Subject: Re: [PATCH v2 6/9] firmware: qcom_scm: update comment for
 ICE-related functions
Message-ID: <X9ARtTERgMYHiX58@google.com>
References: <20201203020516.225701-1-ebiggers@kernel.org>
 <20201203020516.225701-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203020516.225701-7-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Dec 02, 2020 at 06:05:13PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The SCM calls QCOM_SCM_ES_INVALIDATE_ICE_KEY and
> QCOM_SCM_ES_CONFIG_SET_ICE_KEY are also needed for eMMC inline
> encryption support, not just for UFS.  Update the comments accordingly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  drivers/firmware/qcom_scm.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 7be48c1bec96d..f57779fc7ee93 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -965,8 +965,11 @@ EXPORT_SYMBOL(qcom_scm_ice_available);
>   * qcom_scm_ice_invalidate_key() - Invalidate an inline encryption key
>   * @index: the keyslot to invalidate
>   *
> - * The UFSHCI standard defines a standard way to do this, but it doesn't work on
> - * these SoCs; only this SCM call does.
> + * The UFSHCI and eMMC standards define a standard way to do this, but it
> + * doesn't work on these SoCs; only this SCM call does.
> + *
> + * It is assumed that the SoC has only one ICE instance being used, as this SCM
> + * call doesn't specify which ICE instance the keyslot belongs to.
>   *
>   * Return: 0 on success; -errno on failure.
>   */
> @@ -995,10 +998,13 @@ EXPORT_SYMBOL(qcom_scm_ice_invalidate_key);
>   *		    units, e.g. 1 = 512 bytes, 8 = 4096 bytes, etc.
>   *
>   * Program a key into a keyslot of Qualcomm ICE (Inline Crypto Engine), where it
> - * can then be used to encrypt/decrypt UFS I/O requests inline.
> + * can then be used to encrypt/decrypt UFS or eMMC I/O requests inline.
> + *
> + * The UFSHCI and eMMC standards define a standard way to do this, but it
> + * doesn't work on these SoCs; only this SCM call does.
>   *
> - * The UFSHCI standard defines a standard way to do this, but it doesn't work on
> - * these SoCs; only this SCM call does.
> + * It is assumed that the SoC has only one ICE instance being used, as this SCM
> + * call doesn't specify which ICE instance the keyslot belongs to.
>   *
>   * Return: 0 on success; -errno on failure.
>   */
> -- 
> 2.29.2
> 
Looks good to me. Please feel free to add
Reviewed-by: Satya Tangirala <satyat@google.com>
