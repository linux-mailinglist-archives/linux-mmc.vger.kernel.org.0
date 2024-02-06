Return-Path: <linux-mmc+bounces-935-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA75784B45C
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Feb 2024 13:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A63E2282EA1
	for <lists+linux-mmc@lfdr.de>; Tue,  6 Feb 2024 12:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F41C12F5AC;
	Tue,  6 Feb 2024 11:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtTxLIMz"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC9612F384
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220790; cv=none; b=nM3TN26d0Ayx63Y5pvBWIKKrVspO5AqRyrP+pmQ6scxOppz8N8x911P1mC/gBKAvH9jT0rJru+tX+IWqZtOojRrCDU6PqG+TqFu8HtRsetD7S6NsTI0P+U6+CSV0UqF9IsRaEW3iHmzc5qUgibx1/bWeVIlKT9zK8XrhMlosAvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220790; c=relaxed/simple;
	bh=EtsT4PQhPQG5JWztb0+mi4R2d7ka72NiRj+QIgwDG5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nmL5Kr3YNFxW6fN/pOhILLcI6nAwRPLmdZXdC47Vy5GCNQnJBvkMe1SqZpzKjw+kjjxdGgXWyxirhsV/OPUdQmShG2/0LvX7ZF9fWBWLKsKT/vc7qyKQTH13p3+Fn6mG8hnRWBcKPTo/w55wYSqg75eF7Y0XVF9MRtmDctjDj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GtTxLIMz; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-604713c4ee5so12218367b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707220787; x=1707825587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNhycZjEYpR/VohePuZrM34Prmw23zgM6uVQKrTP5kw=;
        b=GtTxLIMzLdlaDjq/Bw5H46F0QD6Zysg6LeAx7+TINdOecjHhufuiBCKu3WYEAEL1tS
         nbkE8nZT83JydFmCmwha0ZT3mKKDxDs2fYVBjlaHbbomFJc/QPbZjoKMd5Zra4gl72+K
         +sTlNTtcj9sHUnkMFgwXqw+zaPRrx6/nSWpp54I5LwKF3pbvnAIXEeWfdIusrOX/777U
         8WnOa1J0b3dZO4NhnqUbdaIwRPNEHsVpM6CEtfXrlI9zizyxVOxIriBnS4irdjrIpPc2
         bpgaqOy+ZSO7+KY2pHW0112AITamvma9DRzckOjtpq1Ig3BxB/ywNJWx/1AkeXNu1HDH
         qEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707220787; x=1707825587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNhycZjEYpR/VohePuZrM34Prmw23zgM6uVQKrTP5kw=;
        b=pLFqGe9eOjCk1rLgeZHbau4wPGVfp34ve3nJmdWvcumNxntBgtLTtswAhCZ+bre6Ut
         QUYy35NiJgU6+oZWgJMeieUM6zZO5/KzE4E8siYii7PrDlCbOj1TJg+pa0EIAoan6ECD
         9on5rfWyNkPSBAKN8DeKOZQfflM1gjOI+7Sc3golvC2N6dmghdEdlOL4bwsj+hts9lAj
         TYHdkkkEFBytJ1pnUACrdFO5AAJCE8HKJUxZU5EKOYUBZLlCT0THliTzwSzJl8vslDPT
         mQ3ZAAmPjSUHF0WC/XsVVvuP9K5WxWVx/SxJCuoMxDL4gsCTb97zMeYHgPig0hsT3iqu
         tF3Q==
X-Gm-Message-State: AOJu0YxSfoQg7PCax2AxA15IBjWly8KfkL9JyPGRJXLg7nAzkQwBurEN
	/ikS1Fyse4crmLhZA+HeJZfdqhst9Xp/PAmxl9xCmKY2gbgQOX/26TuxJdxh65C9oe0INbHrL1y
	1OcsgKc5DrW+81Eq4MzJ6hs/YnijH6Z5e5fP+kw==
X-Google-Smtp-Source: AGHT+IGp4zSfVN0bhdWn/BNXPVm1N0DQtGd+SBJSrjS/zOeOsHkJO47hbNHRq2jlyZogmxAAIrtYFkDNTHHiPQLWpKw=
X-Received: by 2002:a81:b3c7:0:b0:603:bc00:b469 with SMTP id
 r190-20020a81b3c7000000b00603bc00b469mr1635531ywh.11.1707220786825; Tue, 06
 Feb 2024 03:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127232436.2632187-1-quic_gaurkash@quicinc.com> <20240127232436.2632187-4-quic_gaurkash@quicinc.com>
In-Reply-To: <20240127232436.2632187-4-quic_gaurkash@quicinc.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Tue, 6 Feb 2024 12:59:36 +0100
Message-ID: <CACMJSetM_JQ+1bTEszc4EtaUwb2iKkbg3WFWVTsXa14KD_VKCA@mail.gmail.com>
Subject: Re: [PATCH v4 03/15] qcom_scm: scm call for create, prepare and
 import keys
To: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org, 
	andersson@kernel.org, ebiggers@google.com, neil.armstrong@linaro.org, 
	srinivas.kandagatla@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, kernel@quicinc.com, linux-crypto@vger.kernel.org, 
	devicetree@vger.kernel.org, quic_omprsing@quicinc.com, 
	quic_nguyenb@quicinc.com, konrad.dybcio@linaro.org, ulf.hansson@linaro.org, 
	jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org, 
	davem@davemloft.net, herbert@gondor.apana.org.au
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jan 2024 at 00:26, Gaurav Kashyap <quic_gaurkash@quicinc.com> wrote:
>
> Storage encryption has two IOCTLs for creating, importing
> and preparing keys for encryption. For wrapped keys, these
> IOCTLs need to interface with Qualcomm's Trustzone, which
> require these SCM calls.
>
> generate_key: This is used to generate and return a longterm
>               wrapped key. Trustzone achieves this by generating
>               a key and then wrapping it using hwkm, returning
>               a wrapped keyblob.
> import_key:   The functionality is similar to generate, but here,
>               a raw key is imported into hwkm and a longterm wrapped
>               keyblob is returned.
> prepare_key:  The longterm wrapped key from import or generate
>               is made further secure by rewrapping it with a per-boot
>               ephemeral wrapped key before installing it to the linux
>               kernel for programming to ICE.
>
> Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_scm.c       | 182 +++++++++++++++++++++++++
>  drivers/firmware/qcom/qcom_scm.h       |   3 +
>  include/linux/firmware/qcom/qcom_scm.h |   5 +
>  3 files changed, 190 insertions(+)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 4882f8a36453..20dbab765c8e 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1285,6 +1285,188 @@ int qcom_scm_derive_sw_secret(const u8 *wkey, size_t wkey_size,
>  }
>  EXPORT_SYMBOL_GPL(qcom_scm_derive_sw_secret);
>
> +/**
> + * qcom_scm_generate_ice_key() - Generate a wrapped key for encryption.
> + * @lt_key: the wrapped key returned after key generation
> + * @lt_key_size: size of the wrapped key to be returned.
> + *
> + * Qualcomm wrapped keys need to be generated in a trusted environment.
> + * A generate key IOCTL call is used to achieve this. These are longterm
> + * in nature as they need to be generated and wrapped only once per
> + * requirement.
> + *
> + * Adds support for the create key IOCTL to interface
> + * with the secure environment to generate and return a wrapped key..
> + *
> + * Return: longterm key size on success; -errno on failure.
> + */
> +int qcom_scm_generate_ice_key(u8 *lt_key, size_t lt_key_size)
> +{
> +       struct qcom_scm_desc desc = {
> +               .svc = QCOM_SCM_SVC_ES,
> +               .cmd =  QCOM_SCM_ES_GENERATE_ICE_KEY,
> +               .arginfo = QCOM_SCM_ARGS(2, QCOM_SCM_RW, QCOM_SCM_VAL),
> +               .args[1] = lt_key_size,
> +               .owner = ARM_SMCCC_OWNER_SIP,
> +       };
> +
> +       void *lt_key_buf;
> +       int ret;
> +
> +       lt_key_buf = qcom_tzmem_alloc(__scm->mempool, lt_key_size, GFP_KERNEL);

Please use __free(qcom_tzmem) everywhere in this series. You can take
a look at the calls I converted in the series adding this allocator.
It's really useful - especially if the buffer is surely freed within
the same scope.

Bart

[snip]

