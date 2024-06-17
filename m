Return-Path: <linux-mmc+bounces-2606-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 707E090A757
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2024 09:35:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C56B1C21836
	for <lists+linux-mmc@lfdr.de>; Mon, 17 Jun 2024 07:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1501862B0;
	Mon, 17 Jun 2024 07:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hsw5egON"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E1B18F2C2
	for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2024 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609644; cv=none; b=HlvNwt4uGGDFp+5+7Kqiy6cDHkjjMGgXi3KM4ytYIgyHmK7HVwc1sVwo7S562LWWVtkrzTavbXllyqNIN32zLdpygICxiX8hzMNWoBAAu/HDNYiKrsXMlw8Q9AglNktYgxIwSsIAxQBpOlitf+69kQkR3yelGdkSDtb8f9rHQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609644; c=relaxed/simple;
	bh=ZFmi+yUTc9Zjr/M0kxKvyOleY7JfCQGrFTVa2o2QNlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHPMS7rotvOVjdu75Sou+fzi6gHHUN3Y6Vft/u8dpTjqA9vFucyQbG+xhOdWaFwF696KF/b75PfwsijL9wXisDcTw96tDE6bXUX+K2Itm89Cf7gxqjJql5/FOdTTcJSXUbEnU9KCAPbDFYnYJYlFocVlsAzUGC8LkTtkYWzM22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hsw5egON; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc274f438so4372955e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2024 00:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718609640; x=1719214440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aBphVFOrP22wHUL3UOKiauwrKM/dUJgf2+E0bXR1o6w=;
        b=Hsw5egONtdB5Rv2L3vDgQHy8VYNd9jfISdm5F+7cb8oHPb9XwczHqXAePc7TwkcvQ3
         UCw+Zl7HsGbOKvGxEidU0G4K5www6wsNN1Hh2/y51FruMM5yF8ST8GAaqXj6kFcJxIku
         b5gyS9IJJIEUy4Ut7sWE8ZW8YPFyMnl1T6qHsnwHI5nx0fNUXWL+biDLcuYLkcKAbXnU
         8bpD10ZtT35jgr7taKWIKF6zjBfD/m2QqH+RqySm0614DE+53PjXG9Wy7kHFMx6if2Vd
         2bGJY/OaLfkGmMjAIjmx8M6TwpbO/VsKYR+Jn0JjW2orK1wfEQjlbawyk4QiqbSR6210
         HCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718609640; x=1719214440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBphVFOrP22wHUL3UOKiauwrKM/dUJgf2+E0bXR1o6w=;
        b=iwv/g8qW+DMTrIaUK40axdWY3Mw1BSTockZacB8RS3SJvRFI2Ed5hqHYYgkc0hjyHV
         0RcFJA8LubDqgbg/iaem8p8lRnJf5yNfQRSyHEuMsiD2kk4l7U1igg/anJo0+pHDF8NE
         2KIZtNzeVEJWlvPNyglCBxQAOl9DL7pRd+bu1kHNeIDWFGl0DErLO3J2mbBhjloxs82W
         DSrIKt1UWcB5cEAUtzuyonUn7iAq80NZsgwKGCKkJVl9xBsUSgeLJbKSIYbRAAtXkedp
         y2Z6lgaLOQw+sg+ukSMy4l5SHaLvx9GmtjfMe5tQcSVPDz07tlYrYDv17WBCL433GTJT
         Ar9Q==
X-Forwarded-Encrypted: i=1; AJvYcCW3FkBY7O0OXR/VrYNp4RwweUsUQNCggIGCLlI+k5hZKd0iVw5NmFeitM1THAmSlYzsEscQACV0x/zqbbOcDhN3NGOrKiKxZviR
X-Gm-Message-State: AOJu0YzfsU1alcVpDEU9pBj7Mo+2GQqpwGRi5m+69lxdvcjsHVPkIBsi
	9IfJy3/Zq38htvPCUsi7tuH/dgP6cqp9SwtwBuhsVHFFDGHDJrIsukHqZJVA4+A=
X-Google-Smtp-Source: AGHT+IF8TZ85wRS0H2kr1KtmiIH/CU55Vp03UXdrbqOj8557e44sDO8j3EJKyLPHPMMhkL8bWOcIHQ==
X-Received: by 2002:a05:6512:3093:b0:52c:bd36:b8c7 with SMTP id 2adb3069b0e04-52cbd36b937mr1561115e87.53.1718609640435;
        Mon, 17 Jun 2024 00:34:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282f112sm1161208e87.89.2024.06.17.00.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:34:00 -0700 (PDT)
Date: Mon, 17 Jun 2024 10:33:58 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	andersson@kernel.org, ebiggers@google.com, neil.armstrong@linaro.org, 
	srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	kernel@quicinc.com, linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	quic_omprsing@quicinc.com, quic_nguyenb@quicinc.com, bartosz.golaszewski@linaro.org, 
	konrad.dybcio@linaro.org, ulf.hansson@linaro.org, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, mani@kernel.org, davem@davemloft.net, 
	herbert@gondor.apana.org.au, psodagud@quicinc.com, quic_apurupa@quicinc.com, 
	sonalg@quicinc.com
Subject: Re: [PATCH v5 02/15] qcom_scm: scm call for deriving a software
 secret
Message-ID: <gidy3f2b7lfh3nl366vt3ytx75s6xcqx77ahay2yvwn7wnli3p@tdxw3zomvvwr>
References: <20240617005825.1443206-1-quic_gaurkash@quicinc.com>
 <20240617005825.1443206-3-quic_gaurkash@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617005825.1443206-3-quic_gaurkash@quicinc.com>

On Sun, Jun 16, 2024 at 05:50:57PM GMT, Gaurav Kashyap wrote:
> Inline storage encryption may require deriving a software
> secret from storage keys added to the kernel.
> 
> For non-wrapped keys, this can be directly done in the kernel as
> keys are in the clear.
> 
> However, hardware wrapped keys can only be unwrapped by the wrapping
> entity. In case of Qualcomm's wrapped key solution, this is done by
> the Hardware Key Manager (HWKM) from Trustzone.
> Hence, adding a new SCM call which in the end provides a hook
> to the software secret crypto profile API provided by the block
> layer.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 65 ++++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |  1 +
>  include/linux/firmware/qcom/qcom_scm.h |  2 +
>  3 files changed, 68 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

