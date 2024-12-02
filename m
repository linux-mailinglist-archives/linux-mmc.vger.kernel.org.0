Return-Path: <linux-mmc+bounces-4883-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B06429E020B
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 13:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDED16BAA5
	for <lists+linux-mmc@lfdr.de>; Mon,  2 Dec 2024 12:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A351FF61E;
	Mon,  2 Dec 2024 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q2qBpC4J"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11D21FF5F9
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 12:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733141864; cv=none; b=K4bJ1oev/BkH/TgXnP1H+XqqMse1XQ3dc9XEPyVhG8bqMCcAUd3jUhxeUWDNFllspZNZPfsOxQakErJLZ09fSAXRapP4mBo5zHiLBV1Kut+wCg+hbIykdY9uPiHWeHT7jJwmbC+a1hFYIvbdO/2Huq33skZ0iU4aO0GIw00yU8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733141864; c=relaxed/simple;
	bh=cjwiLpyces7oEH/gnZel3kh0F0XZ3KiDL4+nGbd7cRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pU5SL+ewFqw/3kHNqdxrAtmKiy8ia529pSmnPKEVSAbZJfbh/te4mau8O2+TQQm79TJFlJF3nk1RYtP9I01j3GFTjq5yfhCFiAh6AAJvsCjIIdRu1HkKUPiFnMqd8xHfzeG7JMYqXwSd5HbDgzYyt17llhruuEbr67aw+E2NpSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q2qBpC4J; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53e0844ee50so1212860e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 04:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733141860; x=1733746660; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUoLIZvVtbQSISsGIJiv88vjB94vxHsf2pfqlKAM26U=;
        b=q2qBpC4JylFDvH6kZYUcKPn66I2p3ou2NUMcxustQ/c/eMgR/LSuNuKooK0/H5ETxM
         kDa6fuZ8vkaA9f4KHBy78mrfcF6rhVdz3E2HuOk9TCQvu3gN6RsPIc7Sy0cPgGGjI/ir
         BisdLFOuJMV6i2F64eFJbmGSCJxvGDyhKLtXMVnbxMN8hSRX9LeKtvWmDIbHOtuBYu0W
         T1gRhQ3DqgjEf9bqm/xT4Opy3txS9qxUR/AdDhBfijNRH9IWNHSOkdmaogZkvRvdxvBu
         d8ytAvUIsT68+YPUfxTWp9v/2YDI+23n6evqPdT3o4HHZoRemXG5yLyD8g4HPg9ToQMq
         ArOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733141860; x=1733746660;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUoLIZvVtbQSISsGIJiv88vjB94vxHsf2pfqlKAM26U=;
        b=i46b9gl2vUhVGfkmAK+E5iQGDFsn1edJix5JWj1WcEut7uzXpxQq0QTTVx+E4O0que
         iwxCkjCrcGYkQ7usemzpQztr1/aQmNXrBOJizlOBNDFnVtH2l4f8ovGEM9wLozod3ERm
         k36g4G92Zm2jQTdQAqLhAC8N6UF8a6NNc7CYFSycb+SZewHxRhlzsHUcTSy8dJxlpO3K
         p0BZ9505wF48Lzsc7Uf3ziODRyvlY2cH5zhLXyZQ55a/XUilEDYaS+HpQCMT/K+qS8Mq
         GBg4HggNbeLqf1vjl6Dz6WAh37GitDi6tiis+1+c9WDtoO9IQfWfyqMXdarkUNv8sncF
         nYUg==
X-Forwarded-Encrypted: i=1; AJvYcCV2xjLy3+6R938V0OlDJTsLK4Vf9F56Tb8oFk+SqN6s2Z7ix7AI3cOGYYgKxoaYA5ig5J2grwKHsQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtFnbE59Lzkx/aM/N/twF5KOIV4eF1PpU02Vo5iSCWksRiCmM
	HOhNS3Amunw6rgUxhkR07RFRPrNgMfNR2kZe+MikgUpMGuA0xAvLUYKv4anbKqc=
X-Gm-Gg: ASbGncv8+9d8pqwV9nVJeE2G9fr3TLFdWcOF1JFz2WGDU69rD30xGuXz1sEg4ruAOEs
	Q3hLR18muOQr5+sq6JN7hF7R+zYz6JgDwgSW5wqyy+BNy6YXgxpGuKcjxbdvpTPHNpj3BsARNml
	eBedoBxBq7nyOYcDs+oS5cPfwvWUf8nOSj647ZE5UjOOEK9TGDYR0eE/Dcl2UygNLyrVd3aDVg1
	0GYqpmjjsmABQ8vc+ly1yYs47Asf0RZSVfuMwqfa9aK53VoVekdF1K/mOvrOAIaxpVBJ9jTdZyd
	kU9eszSBMQKHmhlDnuEUofyzjzBcLg==
X-Google-Smtp-Source: AGHT+IGhAvYybqFJhAz3sCBw+CQSHdAjkvqJ/iPZp81uMYhUbES1NVq6qCCpGOPW79Fcg/GhD/p3Tw==
X-Received: by 2002:a05:6512:2304:b0:53d:e76b:5e6e with SMTP id 2adb3069b0e04-53df00d9cf4mr11692080e87.31.1733141860084;
        Mon, 02 Dec 2024 04:17:40 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df6497197sm1475981e87.224.2024.12.02.04.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 04:17:38 -0800 (PST)
Date: Mon, 2 Dec 2024 14:17:36 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Asutosh Das <quic_asutoshd@quicinc.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Gaurav Kashyap <quic_gaurkash@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Eric Biggers <ebiggers@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Om Prakash Singh <quic_omprsing@quicinc.com>
Subject: Re: [PATCH RESEND v7 10/17] soc: qcom: ice: add support for hardware
 wrapped keys
Message-ID: <45epch3o66skwhemavcqniqw62zfqyh4qrv2q4ay3esd2kxslu@qv6j4ivp4l3a>
References: <20241202-wrapped-keys-v7-0-67c3ca3f3282@linaro.org>
 <20241202-wrapped-keys-v7-10-67c3ca3f3282@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202-wrapped-keys-v7-10-67c3ca3f3282@linaro.org>

On Mon, Dec 02, 2024 at 01:02:26PM +0100, Bartosz Golaszewski wrote:
> From: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> 
> Now that HWKM support has been added to ICE, extend the ICE driver to
> support hardware wrapped keys programming coming in from the storage
> controllers (UFS and eMMC). This is similar to raw keys where the call is
> forwarded to Trustzone, however we also need to clear and re-enable
> CFGE before and after programming the key.
> 
> Derive software secret support is also added by forwarding the call to
> the corresponding SCM API.
> 
> Wrapped keys are only used if the new module parameter is set AND the
> architecture supports HWKM.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/soc/qcom/ice.c | 128 ++++++++++++++++++++++++++++++++++++++++++++-----
>  include/soc/qcom/ice.h |   4 ++
>  2 files changed, 121 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/soc/qcom/ice.c b/drivers/soc/qcom/ice.c
> index 5f138e278554c..e83e74e39e44f 100644
> --- a/drivers/soc/qcom/ice.c
> +++ b/drivers/soc/qcom/ice.c
> @@ -28,6 +28,8 @@
>  #define QCOM_ICE_REG_BIST_STATUS		0x0070
>  #define QCOM_ICE_REG_ADVANCED_CONTROL		0x1000
>  #define QCOM_ICE_REG_CONTROL			0x0
> +#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16		0x4040
> +
>  /* QCOM ICE HWKM registers */
>  #define QCOM_ICE_REG_HWKM_TZ_KM_CTL			0x1000
>  #define QCOM_ICE_REG_HWKM_TZ_KM_STATUS			0x1004
> @@ -62,6 +64,8 @@
>  #define QCOM_ICE_HWKM_DISABLE_CRC_CHECKS_VAL	(BIT(1) | BIT(2))
>  #define QCOM_ICE_HWKM_RSP_FIFO_CLEAR_VAL	BIT(3)
>  
> +#define QCOM_ICE_HWKM_CFG_ENABLE_VAL		BIT(7)
> +
>  /* BIST ("built-in self-test") status flags */
>  #define QCOM_ICE_BIST_STATUS_MASK		GENMASK(31, 28)
>  
> @@ -69,6 +73,8 @@
>  #define QCOM_ICE_FORCE_HW_KEY0_SETTING_MASK	0x2
>  #define QCOM_ICE_FORCE_HW_KEY1_SETTING_MASK	0x4
>  
> +#define QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET	0x80
> +
>  #define QCOM_ICE_HWKM_REG_OFFSET	0x8000
>  #define HWKM_OFFSET(reg)		((reg) + QCOM_ICE_HWKM_REG_OFFSET)
>  
> @@ -78,6 +84,15 @@
>  #define qcom_ice_readl(engine, reg)	\
>  	readl((engine)->base + (reg))
>  
> +#define QCOM_ICE_LUT_CRYPTOCFG_SLOT_OFFSET(slot) \
> +	(QCOM_ICE_LUT_KEYS_CRYPTOCFG_R16 + \
> +	 QCOM_ICE_LUT_KEYS_CRYPTOCFG_OFFSET * slot)
> +
> +static bool ufs_qcom_use_wrapped_keys;
> +module_param_named(use_wrapped_keys, ufs_qcom_use_wrapped_keys, bool, 0660);
> +MODULE_PARM_DESC(use_wrapped_keys,
> +"Use HWKM for wrapped keys support if available on the platform");

This should go into the previous patch and it should be handled in
qcom_ice_check_supported() instead.

> +
>  struct qcom_ice {
>  	struct device *dev;
>  	void __iomem *base;

[...]

> @@ -313,24 +378,40 @@ int qcom_ice_program_key(struct qcom_ice *ice,
>  
>  	/* Only AES-256-XTS has been tested so far. */
>  	if (algorithm_id != QCOM_ICE_CRYPTO_ALG_AES_XTS ||
> -	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256) {
> +	    (key_size != QCOM_ICE_CRYPTO_KEY_SIZE_256 &&
> +	    key_size != QCOM_ICE_CRYPTO_KEY_SIZE_WRAPPED)) {
>  		dev_err_ratelimited(dev,
>  				    "Unhandled crypto capability; algorithm_id=%d, key_size=%d\n",
>  				    algorithm_id, key_size);
>  		return -EINVAL;
>  	}
>  
> -	memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
> +	if (ufs_qcom_use_wrapped_keys &&

I think it's too late to have the check here.

> +	    (bkey->crypto_cfg.key_type == BLK_CRYPTO_KEY_TYPE_HW_WRAPPED)) {
> +		/* It is expected that HWKM init has completed before programming wrapped keys */
> +		if (!ice->use_hwkm || !ice->hwkm_init_complete) {
> +			dev_err_ratelimited(dev, "HWKM not currently used or initialized\n");
> +			return -EINVAL;
> +		}
> +		err = qcom_ice_program_wrapped_key(ice, bkey, data_unit_size,
> +						   slot);
> +	} else {
> +		if (bkey->size != QCOM_ICE_CRYPTO_KEY_SIZE_256)
> +			dev_err_ratelimited(dev,
> +					    "Incorrect key size; bkey->size=%d\n",
> +					    algorithm_id);
> +		return -EINVAL;
> +		memcpy(key.bytes, bkey->raw, AES_256_XTS_KEY_SIZE);
>  
> -	/* The SCM call requires that the key words are encoded in big endian */
> -	for (i = 0; i < ARRAY_SIZE(key.words); i++)
> -		__cpu_to_be32s(&key.words[i]);
> +		/* The SCM call requires that the key words are encoded in big endian */
> +		for (i = 0; i < ARRAY_SIZE(key.words); i++)
> +			__cpu_to_be32s(&key.words[i]);
>  
> -	err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> -				   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> -				   data_unit_size);
> -
> -	memzero_explicit(&key, sizeof(key));
> +		err = qcom_scm_ice_set_key(slot, key.bytes, AES_256_XTS_KEY_SIZE,
> +					   QCOM_SCM_ICE_CIPHER_AES_256_XTS,
> +					   data_unit_size);
> +		memzero_explicit(&key, sizeof(key));
> +	}
>  
>  	return err;
>  }

-- 
With best wishes
Dmitry

