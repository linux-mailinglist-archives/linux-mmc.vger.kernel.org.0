Return-Path: <linux-mmc+bounces-5030-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 961BD9F7C9F
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Dec 2024 14:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFF15189038C
	for <lists+linux-mmc@lfdr.de>; Thu, 19 Dec 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E087E225411;
	Thu, 19 Dec 2024 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0DhZ2zG"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244CE2253E9
	for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 13:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734616126; cv=none; b=Pporz13SiIyJVhgutYmuWu0eUkvXB/39algNLqZrE9LZSG3mvonBjOZDQ3JYuS8//dCV/GfoYSBSPJi14P+Cdn9N4Wk0Cix78lZYIxWMm6dmIxYmaQr052maIo8x2ipoGnnHs+wWuBlt13n2NDzknmI4OlKW6C/UHn5VU8I2uA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734616126; c=relaxed/simple;
	bh=dx8Z8zcbcEcD/p5AehdRTmFyVw4r+v5gMACGHmVdmnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CX2c3qyUmN0wa16GUWSprLqUC/klKSJz70xzGjdUaoGvuMlI9m26Vwdbjuw93LHuiD+SFhci/mZd5GsJ94GUr/K9mDcBCHq8IQuKgZLlNV5iL9A9jtOgIbtgo2EuqVnfW0I2L5U3+NXxB0JZztMQ7N7C6vOIpz7zmoQk1op+teQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0DhZ2zG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ef4b6719d1so6746997b3.2
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2024 05:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734616124; x=1735220924; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXO1JWc0dzqo7dfc1rG4WRHfe9+6B85YYjaXMsQpUk8=;
        b=y0DhZ2zGrPLufsp5oM/sv6BhZoyfMB7L+eEQCEXGWZ3Fer8puvLITpgz1CDDdwCYWd
         m3YZiBIoXqxpkbpvaofaX4jNpzOqDlyxV9CPp/xiqBKcDGz9XgSTzxCclJeImKu0CBXd
         VhWGrOP611xZjSg6ywj6lZEIzRI2PbsWlaincQ7bIUxot36FlXRCYaveC9VeZ354CUrm
         1s3jJbFAowsRWT0xgNxlPR5dUQUPP5ZzRT8x6jBLu4zxxr5qIlEW2gm6jxiaao3JOtmB
         7Dijau1IQWUEWR0kfBpIdaKJbScBTmTWEx7W5eyQUZXWodXUiTui4K2zINvl5Z1enYxO
         vsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734616124; x=1735220924;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXO1JWc0dzqo7dfc1rG4WRHfe9+6B85YYjaXMsQpUk8=;
        b=nkWSKh+Ij1VAfyGSXNf7TR4cejT+cyOarYk2Yw3b92/mmo2f1H0cF1g+kM3RdvGoou
         0qQShQVpWrhrhSd50y29BKtfMl2D70DeTQbz8ughyFXCklxhvzL45ZxD3pBFAdJwH8e4
         Twi3ulVtQB4wz3ZowzN0EQqdsRZ36F3UhHlrzwW2pLVqE5GA3kVQMVGibI7/HNNwo2Fi
         iHGS4jUo1UqrsiTX8kY1hCMCO79K3EruZiuSphwRJhBlmKDo8/pyv9DlMkl2OIi5xplR
         qQq6Tt+ze6hDhNHBKPGBPBHj4vVUv+7uRqoSbL1dxVlfW0HtkIkxnPLNzjQCvga2U2AD
         Zumg==
X-Forwarded-Encrypted: i=1; AJvYcCXZHSo45K9ZEopu9SWMIeNPJmSN05K/xJclPQCPAjSZjf+is1Spf/y+d4s4M//zKiLSE98COCA5cFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZgl1N0IYLJPQD3WnzdoUTCGK98Dc8f5sN3cL1uucbcjwlNim+
	6nSMt1weFadXR4JAKMpbFvHg3jORtkrVszC3fySmoOKkPhkM3yIrJ1z1HrLB5aLtwyIGwUFKeb7
	EFxsYK92wlxPQ5vWqZAvAdv9nxSEB/gEDDPIjww==
X-Gm-Gg: ASbGncvsW54cH4LvMmqLWiTRseOhCbOHARHS/GKXQO2oxXo6KCRyH3oGk8ttTpOsHTB
	VyJQrZ7Ls13LLx+bqaoc8bKA4s2nLodeiOVTLhFw=
X-Google-Smtp-Source: AGHT+IEjwcNyQmxYJWNy9sVDcxIilhG2jovJzAG4uTM2E71ZmGRx+o9hvF/TOHyKvnCLrmN7UM5vvGMWJdIs1tMfv4k=
X-Received: by 2002:a05:690c:6f83:b0:6ef:4fba:8151 with SMTP id
 00721157ae682-6f3d1e85c3emr52273637b3.19.1734616124150; Thu, 19 Dec 2024
 05:48:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241213041958.202565-1-ebiggers@kernel.org> <20241213041958.202565-7-ebiggers@kernel.org>
In-Reply-To: <20241213041958.202565-7-ebiggers@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Dec 2024 14:48:08 +0100
Message-ID: <CAPDyKFpgM4oGv=KYyiS5qE5yznAYhMuHBm5pP6S4OVenLjecrQ@mail.gmail.com>
Subject: Re: [PATCH v10 06/15] mmc: crypto: add mmc_from_crypto_profile()
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Gaurav Kashyap <quic_gaurkash@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>, 
	Bart Van Assche <bvanassche@acm.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Jens Axboe <axboe@kernel.dk>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Dec 2024 at 05:20, Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
>
> Add a helper function that encapsulates a container_of expression.  For
> now there is just one user but soon there will be more.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/cqhci-crypto.c | 5 +----
>  include/linux/mmc/host.h        | 8 ++++++++
>  2 files changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-crypto.c b/drivers/mmc/host/cqhci-crypto.c
> index d5f4b6972f63..2951911d3f78 100644
> --- a/drivers/mmc/host/cqhci-crypto.c
> +++ b/drivers/mmc/host/cqhci-crypto.c
> @@ -23,14 +23,11 @@ static const struct cqhci_crypto_alg_entry {
>  };
>
>  static inline struct cqhci_host *
>  cqhci_host_from_crypto_profile(struct blk_crypto_profile *profile)
>  {
> -       struct mmc_host *mmc =
> -               container_of(profile, struct mmc_host, crypto_profile);
> -
> -       return mmc->cqe_private;
> +       return mmc_from_crypto_profile(profile)->cqe_private;
>  }
>
>  static int cqhci_crypto_program_key(struct cqhci_host *cq_host,
>                                     const union cqhci_crypto_cfg_entry *cfg,
>                                     int slot)
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index f166d6611ddb..68f09a955a90 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -588,10 +588,18 @@ static inline void *mmc_priv(struct mmc_host *host)
>  static inline struct mmc_host *mmc_from_priv(void *priv)
>  {
>         return container_of(priv, struct mmc_host, private);
>  }
>
> +#ifdef CONFIG_MMC_CRYPTO
> +static inline struct mmc_host *
> +mmc_from_crypto_profile(struct blk_crypto_profile *profile)
> +{
> +       return container_of(profile, struct mmc_host, crypto_profile);
> +}
> +#endif
> +
>  #define mmc_host_is_spi(host)  ((host)->caps & MMC_CAP_SPI)
>
>  #define mmc_dev(x)     ((x)->parent)
>  #define mmc_classdev(x)        (&(x)->class_dev)
>  #define mmc_hostname(x)        (dev_name(&(x)->class_dev))
> --
> 2.47.1
>

