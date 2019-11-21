Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4A105A61
	for <lists+linux-mmc@lfdr.de>; Thu, 21 Nov 2019 20:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKUT2S (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 21 Nov 2019 14:28:18 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33827 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbfKUT2S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Nov 2019 14:28:18 -0500
Received: by mail-ot1-f68.google.com with SMTP id w11so4035220ote.1;
        Thu, 21 Nov 2019 11:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CHTfKDAdZLhL1Zm6CO6s2kP8nxK/JV3N7UW7tF4nQP4=;
        b=WrwjpA9U7OiemGH4eYKo8N7n3uHifrrmMCswleR0zyUb1hO93Y35no4bTkFuGFXa39
         7uvEl/kSbAxzv/L9ak9m4uWfXyxPxDxpw7H+iDcZlX1+jQhJlCoF22la9gFOev373W9n
         TyljE5D1gfQbw9smY0ahOs81RUG/t4w5AbRCNMNGsN8oLszhIHy/KKuaE8Y6nIV+JNZp
         Cemzhngv7BLmRY1bGMZzutENOUYD5NZK71tvlBV3OhUms7sv8sHwowDKDzeCFgh7MjoE
         KSEIp/U8cNOqqzoKOL+TfLVGzcToTNut2vP7FlPswLtJjEuQiC5Vq/KreuFs98T9KqA0
         rUhA==
X-Gm-Message-State: APjAAAVqq50mRGKpKYAVrd+89LrYIADWAnHMm/2nTwZWeMLQHsG7yVD5
        W+bZ7V6nHkKEv43rzUH5kQ==
X-Google-Smtp-Source: APXvYqwSY+m1VVKP1lJWWFMDzjmXAD1VirqNMJL368kLdu7zD5Tqa73Qd9dLlvlXyGQDu+Uma4tvig==
X-Received: by 2002:a9d:365:: with SMTP id 92mr8439326otv.9.1574364497464;
        Thu, 21 Nov 2019 11:28:17 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u204sm1219085oig.35.2019.11.21.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:28:16 -0800 (PST)
Date:   Thu, 21 Nov 2019 13:28:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        jianxin.pan@amlogic.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lnykww@gmail.com, yinxin_1989@aliyun.com
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: Document the Amlogic Meson SDHC
 MMC host controller
Message-ID: <20191121192816.GA7377@bogus>
References: <20191117142716.154764-1-martin.blumenstingl@googlemail.com>
 <20191117142716.154764-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191117142716.154764-2-martin.blumenstingl@googlemail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Nov 17, 2019 at 03:27:15PM +0100, Martin Blumenstingl wrote:
> This documents the devicetree bindings for the SDHC MMC host controller
> found in Meson6, Meson8, Meson8b and Meson8m2 SoCs. It can use a
> bus-width of 1/4/8-bit and it supports eMMC spec 4.4x/4.5x including
> HS200 mode (up to 100MHz clock).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  .../bindings/mmc/amlogic,meson-mx-sdhc.yaml   | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdhc.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
