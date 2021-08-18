Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C243F0A90
	for <lists+linux-mmc@lfdr.de>; Wed, 18 Aug 2021 19:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhHRRwi (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 18 Aug 2021 13:52:38 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:43992 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbhHRRwf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Aug 2021 13:52:35 -0400
Received: by mail-oi1-f175.google.com with SMTP id bf25so4460180oib.10;
        Wed, 18 Aug 2021 10:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zGXh/RAPuDf810DfB04607FGfrFXnv4n4alUZkuGjw=;
        b=nOg5H3xrX4cL57uE58GpFKyinQDSss5KHKZLY/dYFfj2juwvvTf47+f6zJox47s3zD
         jATK+IKOYrwgia/Ne+fYR52mKh+SRKFtPUTysNyuNLFFuJ8kRgzWdvRozul65+Oxk1HB
         t1fDFRN+Fp2rOuR7+kAyNnXXoP9BEMEptW72aqOmHY7+nO8hRHinxEvvTX8rCX4YEzzz
         g/rF4se+rtq06bFd00qsUQHafmsHW+2DJ9STpFDiGf62/cg6XdfUOjqpXpH8grA5EUQf
         bUKkyphP6aa60886N7Lt6uFALUSltaHbEFjDKfdviofDGiqzVyeLUe5cQDJ6XB8dqcRZ
         iSaA==
X-Gm-Message-State: AOAM53049lhkbxeyLBnKdU4luWSvFzAS/HJ7mos+mW5+64cUKMI01aJC
        mwwuCw9PARGrII8DX/SeCQ==
X-Google-Smtp-Source: ABdhPJxPZtmQIq+VmHFY1s0tpe+o/ow+qx6GwRkzGSWaX1ozZCDegAIlFNe7xXC0FYxjfF4ek5fMlw==
X-Received: by 2002:a05:6808:286:: with SMTP id z6mr8136803oic.48.1629309120619;
        Wed, 18 Aug 2021 10:52:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id p64sm166549oib.4.2021.08.18.10.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 10:51:59 -0700 (PDT)
Received: (nullmailer pid 2824526 invoked by uid 1000);
        Wed, 18 Aug 2021 17:51:58 -0000
Date:   Wed, 18 Aug 2021 12:51:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     haibo.chen@nxp.com
Cc:     ulf.hansson@linaro.org, aisheng.dong@nxp.com, shawnguo@kernel.org,
        festevam@gmail.com, linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        s.hauer@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: fsl-imx-esdhc: add a new compatible
 string
Message-ID: <YR1IvutH4RNxiivs@robh.at.kernel.org>
References: <1629278277-7313-1-git-send-email-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629278277-7313-1-git-send-email-haibo.chen@nxp.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Aug 2021 17:17:57 +0800, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> Lack a compatible string "fsl,imx6sll-usdhc", so add it here.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
