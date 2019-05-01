Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 797F410DEC
	for <lists+linux-mmc@lfdr.de>; Wed,  1 May 2019 22:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEAUX4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 1 May 2019 16:23:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44890 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfEAUX4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 May 2019 16:23:56 -0400
Received: by mail-ot1-f66.google.com with SMTP id d24so87991otl.11;
        Wed, 01 May 2019 13:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xhwLDL0FaJ2M5yj/J//1qH/Ga5dzDW6zM+tv/2cUHl4=;
        b=K7fGlVIkS6s8qHkjOW4fiwGGOXULqTZIXEwqBykpDaIk3oLOTUaWa3HbNsq3K8rqvq
         cA58PIXIvk3jf9qBT+gLBv5F/at3Ptx47bp5srzI4oJ+sFX829sSeL4Sa4ai/wKIkv9x
         barn2S5YRHLq3+GeGqiRDnEZCGK8UHX0AO5YCEKm6JqwP1Gs6h5suYcauNXnzaTYtoiH
         4l3FBc4wgoIwrkEwfX4TkkhxUyQLNjaLmLMqoHTZqsrB/0MTuri1AHpbqsXONzXs9WC+
         Z/1gS1Svpk3iWLYQ2jtBjjlvv9qF4+6ZCp+HA3A2yKFj3VB/Mp0MeRsUBg7Q0dM8KTji
         RPzQ==
X-Gm-Message-State: APjAAAUaMwOCjdMwvA8GlApUdwF/hoe+tBIV0g0aEu0dpVhmTl55nBAD
        VQWEvkZ62qV+1XseVgDMCQ==
X-Google-Smtp-Source: APXvYqzRrVnMMrtwYHb/m+DSgs+Iezq+Hs9Pa13nIrzLLcmIFRrIkCn1jnCS2r3MsWWWva727WESxw==
X-Received: by 2002:a9d:4c8a:: with SMTP id m10mr3902957otf.322.1556742235456;
        Wed, 01 May 2019 13:23:55 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d5sm2485913otl.68.2019.05.01.13.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:23:54 -0700 (PDT)
Date:   Wed, 1 May 2019 15:23:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     BOUGH CHEN <haibo.chen@nxp.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: fsl-imx-esdhc: add imx7ulp
  compatible string
Message-ID: <20190501202353.GA30853@bogus>
References: <20190429090310.25484-1-haibo.chen@nxp.com>
 <20190429090310.25484-2-haibo.chen@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429090310.25484-2-haibo.chen@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 29 Apr 2019 08:55:32 +0000, BOUGH CHEN wrote:
> Add imx7ulp compatible string.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
