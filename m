Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB147697BF7
	for <lists+linux-mmc@lfdr.de>; Wed, 15 Feb 2023 13:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjBOMiU (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 15 Feb 2023 07:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjBOMiS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Feb 2023 07:38:18 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4203864C
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:38:17 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id kk7-20020a17090b4a0700b00234463de251so2010563pjb.3
        for <linux-mmc@vger.kernel.org>; Wed, 15 Feb 2023 04:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h2yv6r/tkJhh1AQWXNmS332xczLIXC4hXyJsLrF/F0U=;
        b=OIBjB/DieDnrOnlkZX38SIz0J8fusd5SUL3z7LhO03UDu0zSc2bF0zd/csrTgGS51A
         Tc9DGgBQyDaF+JnP7kwGKpKNrF8i+hc/SESRdMOHJMsIZqEwIzJjyh8N5qFIcVP3GXqQ
         pRnNRrtx+2lM8vcpWvBxcz+U6NDkMG/qapwgr7qXZOKAUzGfrvnU3vzxjXtm5YIaUaYS
         pWgDHxuYgb6/3pg1/Cvb+73LAb0dUWJJryZp1DV0CmZJ9wFHzYYFbW0ox0eXDBkt6eEa
         u82VXVydJaF9Jco30Qs4Yj76S1SesscsMggEHVtUP9qBWVXxfLSWx7StkNtu4tNL0m0I
         q7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h2yv6r/tkJhh1AQWXNmS332xczLIXC4hXyJsLrF/F0U=;
        b=KfqE7y7yvnMNKiJxJHgpDR1pVIFVAgyqipBziclP2CDLfAbR/I9ROzoq8EdQ7UuFYa
         6hb1Jeawhqw/qu9rn9Vsd6DA9vhSczqMHeWjTxxnDl0Kx7zmCPHT3RQAlNrOVeANDWWX
         qewNlzwFfA/ekAXz8upl5CVtl+e2vPlPz1BOWb/AObnrG2qZ9ZYWqyvrtLUiFnDxgss1
         Oz4XxHSvErw/wKxNao3A2S4+aZqKGNj3K03Zeit5VgcECVntP/Utu1uEx0joqCBFLahS
         pRBMYx+irlUBtWElhayAWf5z0InZmjviAnPY0+6bh3osUqFJzZOGV7MVcLtxr4tZOPjI
         w8LA==
X-Gm-Message-State: AO0yUKVpCL3r39KgI3CvhJmptZrLaReqYvO9bZWl+bCtV7BR0vv6LLNq
        ID9kY+wRhfZsjJIDH/8mzCeFCOy4zJhHzSq1s0Lx5W5+LXNYCw==
X-Google-Smtp-Source: AK7set/BkYD3N5v5x2nC92Owv4rtr6MfxWS5CNY0wa/3//92Ay6+kA+EpQho3FnMO/ZQjPpKMjAhyuKwp3cmSKz9wXc=
X-Received: by 2002:a17:90a:2dcf:b0:230:ae51:1cdc with SMTP id
 q15-20020a17090a2dcf00b00230ae511cdcmr459554pjm.120.1676464697285; Wed, 15
 Feb 2023 04:38:17 -0800 (PST)
MIME-Version: 1.0
References: <20230215113249.47727-1-william.qiu@starfivetech.com>
In-Reply-To: <20230215113249.47727-1-william.qiu@starfivetech.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 15 Feb 2023 13:37:40 +0100
Message-ID: <CAPDyKFqJxrLh+pgQ-u_Lwxv4_TsH--rga049GBTqKAa_M14_yw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] StarFive's SDIO/eMMC driver support
To:     William Qiu <william.qiu@starfivetech.com>
Cc:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 15 Feb 2023 at 12:32, William Qiu <william.qiu@starfivetech.com> wrote:
>
> Hi,
>
> This patchset adds initial rudimentary support for the StarFive
> designware mobile storage host controller driver. And this driver will
> be used in StarFive's VisionFive 2 board. The main purpose of adding
> this driver is to accommodate the ultra-high speed mode of eMMC.
>
> The last patch should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20221220011247.35560-1-hal.feng@starfivetech.com/
>
> Changes v3->v4:
> - Added documentation to describe StarFive System Controller Registers.
> - Added aon_syscon and stg_syscon node.
> - Fixed some checkpatch errors/warnings.
>
> Changes v2->v3:
> - Wraped commit message according to Linux coding style.
> - Rephrased the description of the patches.
> - Changed the description of syscon regsiter.
> - Dropped redundant properties.
>
> Changes v1->v2:
> - Renamed the dt-binding 'starfive,jh7110-sdio.yaml' to 'starfive,jh7110-mmc.yaml'.
> - Changed the type of 'starfive,syscon' and modify its description.
> - Deleted unused head files like '#include <linux/gpio.h>'.
> - Added comment for the 'rise_point' and 'fall_point'.
> - Changed the API 'num_caps' to 'common_caps'.
> - Changed the node name 'sys_syscon' to 'syscon'.
> - Changed the node name 'sdio' to 'mmc'.
>
> The patch series is based on v6.1.
>
> William Qiu (4):
>   dt-bindings: mmc: Add StarFive MMC module
>   mmc: starfive: Add sdio/emmc driver support
>   riscv: dts: starfive: Add mmc node
>   dt-bindings: syscon: Add StarFive syscon doc
>
>  .../bindings/mmc/starfive,jh7110-mmc.yaml     |  77 ++++++++
>  .../bindings/soc/starfive/jh7110-syscon.yaml  |  51 +++++
>  MAINTAINERS                                   |  11 ++
>  .../jh7110-starfive-visionfive-2.dtsi         |  23 +++
>  arch/riscv/boot/dts/starfive/jh7110.dtsi      |  47 +++++
>  drivers/mmc/host/Kconfig                      |  10 +
>  drivers/mmc/host/Makefile                     |   1 +
>  drivers/mmc/host/dw_mmc-starfive.c            | 186 ++++++++++++++++++
>  8 files changed, 406 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/starfive,jh7110-mmc.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/starfive/jh7110-syscon.yaml
>  create mode 100644 drivers/mmc/host/dw_mmc-starfive.c
>

I have dropped the v3 patches and applied patch1 and patch2 from the
v4 series instead, for my next branch, thanks!

Kind regards
Uffe
