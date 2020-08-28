Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6C3F2562EB
	for <lists+linux-mmc@lfdr.de>; Sat, 29 Aug 2020 00:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1WYp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Fri, 28 Aug 2020 18:24:45 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42522 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1WYm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Aug 2020 18:24:42 -0400
Received: by mail-io1-f67.google.com with SMTP id g13so588350ioo.9;
        Fri, 28 Aug 2020 15:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cIScKR8zsbzqHbIy7s24xoivHGWUPIZ8GH20k6+Rx6Y=;
        b=XJgY5v+cWjhGhSiEzqfy+NwP/GqEHptNYXvgfBlzms7Jguiq/9b7Z6pHOGrIzXhlob
         nJXMg1eiYpJHbWzQX0GzXInlIeAL35TeTF/GWLhGUz2GgznTuSrNy1KStfPWqqyu/6M6
         5BMp0ffbItqLuglg0ndedXPyZ6uYtwpfnOSqrYG8XG620GpKEsbOoO2iOTmBxlZQZGfP
         rbRLJAJwPpYNHrv8HpjWGWLP8+HN9UwlYu9iFcCrdsqH8hafL1Xm7249lA5bLRICcAuq
         GZ4f5RS4nqA3gi5AwUl2PJ+FmzG1iUUaQd+kXJ+mfDF4mUtb6UfB1CRLmgM/scf83bkP
         dQfA==
X-Gm-Message-State: AOAM532DMr4HzyCHEYKQxK2p40LSF+LGDU6sYru5p+8lZ/FB6ZAHaraS
        h3GaG3mrp6qwe5X2XdPq6A==
X-Google-Smtp-Source: ABdhPJxIlMnntSPRoVEw2ciZDRXR6pWk08c+7w6ub4GAsfRLFVKrB5WuoiBkyoaKa0yKmzOv/6WA6g==
X-Received: by 2002:a6b:e609:: with SMTP id g9mr771981ioh.26.1598653481722;
        Fri, 28 Aug 2020 15:24:41 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d19sm268186iop.14.2020.08.28.15.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:24:41 -0700 (PDT)
Received: (nullmailer pid 3512595 invoked by uid 1000);
        Fri, 28 Aug 2020 22:24:40 -0000
Date:   Fri, 28 Aug 2020 16:24:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mmc-next v3 1/2] dt-bindings: mmc: add alias example
Message-ID: <20200828222440.GA3507259@bogus>
References: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Aug 25, 2020 at 03:44:40PM +0200, Matthias Schiffer wrote:
> As for I2C and SPI, it now is possible to reserve a fixed index for
> mmc/mmcblk devices.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
> 
> v3: new patch
> 
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index b96da0c7f819..22ed4a36c65d 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -367,6 +367,14 @@ examples:
>      };
>  
>    - |
> +    /*
> +     * Optionally define an alias to reserve a fixed index for the
> +     * mmc and mmcblk devices
> +     */
> +    aliases {
> +        mmc0 = &mmc3;
> +    };

This will break if we improve schemas because this node is actually 
/example-1/aliases.

So please drop. If you want, I'd really like to have a defined set (i.e. 
a schema) of alias names. This would require deleting a bunch on some 
platforms that just made up a bunch of them.

> +
>      mmc3: mmc@1c12000 {
>          #address-cells = <1>;
>          #size-cells = <0>;
> -- 
> 2.17.1
> 
