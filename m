Return-Path: <linux-mmc+bounces-5841-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E15A5F954
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Mar 2025 16:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A98B3B647F
	for <lists+linux-mmc@lfdr.de>; Thu, 13 Mar 2025 15:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4F5268C63;
	Thu, 13 Mar 2025 15:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GOK0sdbG"
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BA3268690
	for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741878827; cv=none; b=VMluk6lZihRwCnqHpB4//kXNsmdxPcObOuTHi+CbNZStaoYEbcePEZ9S7KONGo8fq6rpgip8vtyX5VJE32LmWOsJ9JbwhVIFLFj8BogUswtl/6hpX6CPn+/nEGPFLItk5wZFDtO4tAXqg4Vvxiq6gwR/KE9NrnwvBTFI9NZYJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741878827; c=relaxed/simple;
	bh=fJxfW2SO60LSZjE08ryPgcw3EaJ/8K92lDP2S5xhGvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPqH2uvCf3y5onKFMj/1Og8eowKWz6SzwBsWF3B+WVXfiHvufxhWLpHIzApNFHFRWM76FCdE9voZvNPmNBAGmCFFkgRtiVr71KOq5jHd0ex4ekfiuw7dWl/lLnghH82bXXLPPYM3I9I664HuleQI2c8THsoNtiUUF9XiSY9Tamo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GOK0sdbG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-224191d92e4so23069495ad.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Mar 2025 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741878821; x=1742483621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LtjPSYCYextd8p+081cZMv9XSGQU1Zsd9DWrufPXUHg=;
        b=GOK0sdbG11u5OurIiq3TpSuv/nEG91FWuRhy/KO1o2me9bJTV4nNsMNHTn8AFIytpb
         8xoheskVv4kgI+05jin+Wx7gq7BL1pQrY6xYlMVNa6CBG9jiU0jUfybt3+xvtJdZ9WXZ
         Y7KQvzaKo+N6C2eszX5gtCYUeITNRfsPTMKH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741878821; x=1742483621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LtjPSYCYextd8p+081cZMv9XSGQU1Zsd9DWrufPXUHg=;
        b=xPrvoDWn6qo2ENc7t/kq6jlrmWvPAG90AwRlbRn+YihYUns9o/5bUDtlVql4wk0SnD
         egFqvDCNx3fFjdlp/CUE/y7mktMMUjz5LEEhwrOndUaldI0RbZNdaLCl71T9ZRgnmWqn
         kuzDQkxfk5YCNPHRzpNxYOu3lxOnmXP2YIeAIDFGkIQjy8GDAjsbrHCAyuqzXb/mLqBb
         7D28DnxBI9muZhsMwWRFElPSF7p78GPKDGRC8ansnsbLsLsMRb/whF3kXTABXnqIeywz
         iUgDMhBKOuJAzIOaGyIbziUHnQ7JnhZ3xyVIPhabc4VuH8ztPYvLktpqIm5VTVm1AUr9
         HMqA==
X-Forwarded-Encrypted: i=1; AJvYcCWUXhcS2dGJSMET38bAtSUSYlvPyKklOYK0A/Cpndla7hFyZJDUNE/B3PJ1hi8vcMwZOGqSHSt6TYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+4wUwMrM8IWer2jOGBDydDwgX1ZBrJ4ChFi9BAUC1lA4DgA/g
	HGWKZcJL653eBdTy39n/oy78OLEYgorlzYGJsCeYTuxkrYtNqJyyyZ9fCDNem/tK187RJ//MWmk
	=
X-Gm-Gg: ASbGnculJr/aBGfeKngYRBa4NrTqNzMc3NQgb0f03fWy2QuY6TjYuuSk5M4yGffEKnk
	ZBbe68Sfu8AmgxwsYdqfRe7qbDvKJInQB/ic/fE3qra4isD6lWaKGwcAd7cwLJkITi7Y+ZTYIfI
	yCIsswKqutLw9SIZwhvQ2b/AhwUTL7tUA4Op+z+YBKtGe/m2MDFQGaJR1CKGwGeaEOSi4oxSH5y
	/JoamdPLmrGJfpPtq/pBQc3CZ36Yijg0v0ef4WU8KS5TryPoyrYGT1GLKdp0w3q3c2q4rXM2U6r
	NSD3sv3y7waSO8ObhkxJE19zCa66FdN5jOLTa+/rTaC04KA9KuNHCVbOQ18vs9oVlIUYOFboc3Q
	yIBXvlRgxHlapUdS/R+8=
X-Google-Smtp-Source: AGHT+IH6rVvz6wUlxxNUwr/JAWpyXdb7amienre/dUzOfRJnNc3NkCdr7ltThD0dYTVCfDPZwdv9wQ==
X-Received: by 2002:a17:902:ef4e:b0:223:628c:199 with SMTP id d9443c01a7336-22428c1cca9mr373944625ad.52.1741878821152;
        Thu, 13 Mar 2025 08:13:41 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbebebsm14416825ad.201.2025.03.13.08.13.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 08:13:39 -0700 (PDT)
Message-ID: <06ee4b30-e4c8-4670-9054-b30827ca8931@broadcom.com>
Date: Thu, 13 Mar 2025 08:13:39 -0700
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: sdhci-brcmstb: add cqhci suspend/resume to PM ops
To: Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250311165946.28190-1-kamal.dasu@broadcom.com>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20250311165946.28190-1-kamal.dasu@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/2025 9:59 AM, Kamal Dasu wrote:
> cqhci timeouts observed on brcmstb platforms during suspend:
>    ...
>    [  164.832853] mmc0: cqhci: timeout for tag 18
>    ...
> 
> Adding cqhci_suspend()/resume() calls to disable cqe
> in sdhci_brcmstb_suspend()/resume() respectively to fix
> CQE timeouts seen on PM suspend.
> 
> Fixes: d46ba2d17f90 ("mmc: sdhci-brcmstb: Add support for Command Queuing (CQE)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
> ---
>   drivers/mmc/host/sdhci-brcmstb.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
> index 0ef4d578ade8..48cdcba0f39c 100644
> --- a/drivers/mmc/host/sdhci-brcmstb.c
> +++ b/drivers/mmc/host/sdhci-brcmstb.c
> @@ -503,8 +503,15 @@ static int sdhci_brcmstb_suspend(struct device *dev)
>   	struct sdhci_host *host = dev_get_drvdata(dev);
>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>   	struct sdhci_brcmstb_priv *priv = sdhci_pltfm_priv(pltfm_host);
> +	int ret;

Hopefully this won't be causing a possibly uninitialized warning.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


