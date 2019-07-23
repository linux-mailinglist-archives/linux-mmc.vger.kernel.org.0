Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8C3713C5
	for <lists+linux-mmc@lfdr.de>; Tue, 23 Jul 2019 10:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfGWIRo (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 23 Jul 2019 04:17:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45599 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733141AbfGWIRn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Jul 2019 04:17:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so28664581lfm.12
        for <linux-mmc@vger.kernel.org>; Tue, 23 Jul 2019 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kG+OzI+z87Zf3fJp+hPCemews8fd4ihzvjTAjUmHLho=;
        b=b7Csj3G55G/5GJnEP82ndC4wvbhEB82fiHfvbh8iXu0JtNiwVid5uIw7S+TQuJUzm4
         Yxpk4Gq5jUXw1glHWI4hD0vNOhj9cdmiT1MDpzVICccDPJX5+zxEAFCVb57tzZjdvUhD
         bx+PKItfq/g9p42xn81XB9RkIF/28h4Gr3LNQickg7Sf/9T8MIFfxQqrX18J8gFQsdYQ
         EgljPUkfkjB8nUs+BiclkxXD2wvhU9UOjXjGMJmxS65H0XRyWZwazKc/Ed8O9Vidt1dX
         eN5WwDPC3PU6iD3rWQLJ2il8joK1WEE2VlSgcME5V08cZqjcyEi0Om1Zmms7LVOKDREH
         vcsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kG+OzI+z87Zf3fJp+hPCemews8fd4ihzvjTAjUmHLho=;
        b=hgFKZ3uhV4AYThwA4jgyfIll44872GxnDs94B/qOSo0r8G0vNqeJrIV3RWMh0kVpkp
         YwE6YOxeiS/2wNaD43b/nehjR3knCpvBWTurv2Tqkp9k9vzY7p3M38Ra1dTxkJrlOmF5
         nYseOyDce4ucEgUVi22gm9S8AyZKIVGC0ztON9cLvRh4BZ2ePiJbg6J0AUTuoe7LpjWj
         c7PxBSA4cZbV2XRxP9DIMO+rwexbDRLvSYIoEf/Ijyw3GKcyoJ4izHg57ssqb0BkWrDj
         Q68pK1T6WCwAYLvmsXjO1Mls2rziRNGH7dG42gHAbhj1Sk6CHp2yFNkSKU7v4E1cdMEq
         CjLA==
X-Gm-Message-State: APjAAAVBoip84b9XKTzXxQ91gsrKQMfSl0i6cN0RmKgakjj/LYTK4Y7q
        rww6IIv+n7RaFxGqzwm8eOwt3w==
X-Google-Smtp-Source: APXvYqxGSeEsBpTjFz56E331Sz1Uf1zr152A+X0wCTd9x1epLW3KOc4iQknOO6i0QucClN2gWuZziw==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr33684786lff.81.1563869861549;
        Tue, 23 Jul 2019 01:17:41 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:643:1083:8131:627b:cb64:c17a? ([2a00:1fa0:643:1083:8131:627b:cb64:c17a])
        by smtp.gmail.com with ESMTPSA id m21sm7770031ljj.48.2019.07.23.01.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jul 2019 01:17:40 -0700 (PDT)
Subject: Re: [PATCH v8 2/5] iommu/dma: Add a new dma_map_ops of
 get_merge_boundary()
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        ulf.hansson@linaro.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joro@8bytes.org, axboe@kernel.dk
Cc:     wsa+renesas@sang-engineering.com, linux-mmc@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-block@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
References: <1563859608-19456-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1563859608-19456-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <ae95cc2e-38b4-0ed9-744a-67f03f220a3f@cogentembedded.com>
Date:   Tue, 23 Jul 2019 11:17:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1563859608-19456-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

On 23.07.2019 8:26, Yoshihiro Shimoda wrote:

> This patch adds a new dma_map_ops of get_merge_boundary() to
> expose the DMA merge boundary if the domain type is IOMMU_DOMAIN_DMA.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   drivers/iommu/dma-iommu.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a7f9c3e..f3e5f2b 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -1085,6 +1085,16 @@ static int iommu_dma_get_sgtable(struct device *dev, struct sg_table *sgt,
>   	return ret;
>   }
>   
> +static unsigned long iommu_dma_get_merge_boundary(struct device *dev)
> +{
> +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> +
> +	if (domain->type != IOMMU_DOMAIN_DMA)
> +		return 0;	/* can't merge */
> +
> +	return (1 << __ffs(domain->pgsize_bitmap)) - 1;

    Not 1UL?

> +}
> +
>   static const struct dma_map_ops iommu_dma_ops = {
>   	.alloc			= iommu_dma_alloc,
>   	.free			= iommu_dma_free,
[...]

MBR, Sergei
