Return-Path: <linux-mmc+bounces-412-lists+linux-mmc=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F18880B5D3
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 19:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FAC01C2085A
	for <lists+linux-mmc@lfdr.de>; Sat,  9 Dec 2023 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6068D199A5;
	Sat,  9 Dec 2023 18:14:15 +0000 (UTC)
X-Original-To: linux-mmc@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D1FC2;
	Sat,  9 Dec 2023 10:14:12 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9e9f3a3abso1266538a34.3;
        Sat, 09 Dec 2023 10:14:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702145651; x=1702750451;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G5d03w0HlhTpGtJ6wyqYSsGYLH7rsQTYV63itLXFV8g=;
        b=eURlC5O4d0C04HrNH5gxhx6oJqOKPkskkKrK+YlnTAqCKt/BqEUkPqWtoaJ03ouAoT
         xqx07mfOhNE2MNU3mUPpdsbOnYZC7GbX4qWREUlSjvK9GDTYD4BmNzvdTilf9e4t2qt5
         r1oojgV0FP08vY+Dm+v3BjfoYbPkM5W7WMR3yW10icMpx4kj1ifEmd3Vo2pV5EhLZ0Cz
         9JzWACiHoHdBTQlY2Yjz2G7oxJOcZHPhnZxjlUDDUZSnFVDr7pvy1upiVUjoQ1AoeXw5
         u8QsG6x62Vb7jwU56QPgffQHzkJFIeqYpZXCjKUb8squa+OegbtXQBSIf1SDckvIqz1O
         bgWQ==
X-Gm-Message-State: AOJu0YzOzEwG9paMWDyh0dLUgbfct9GP1xC3jnxfSIEOHzm16TnX5OzA
	AqQDh0EasDsSll7ABrsZmQ==
X-Google-Smtp-Source: AGHT+IGlav0rDJKVQNAn/DjrZw8SZvW5IIiaWNqA37+MFSHe7Ox40MSPatBoD4bGAO59TZhydzaV1Q==
X-Received: by 2002:a05:6870:3325:b0:1fb:75b:2fc6 with SMTP id x37-20020a056870332500b001fb075b2fc6mr2399447oae.93.1702145651337;
        Sat, 09 Dec 2023 10:14:11 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c25-20020a9d4819000000b006d876476f6dsm852704otf.67.2023.12.09.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 10:14:10 -0800 (PST)
Received: (nullmailer pid 1553160 invoked by uid 1000);
	Sat, 09 Dec 2023 18:14:09 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, alcooperx@gmail.com, Kamal Dasu <kdasu@broadcom.com>, f.fainelli@gmail.com
In-Reply-To: <20231209165816.39044-1-kamal.dasu@broadcom.com>
References: <20231209165816.39044-1-kamal.dasu@broadcom.com>
Message-Id: <170214564970.1553144.16154651415666446700.robh@kernel.org>
Subject: Re: [V3, 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: Add support
 for 74165b0
Date: Sat, 09 Dec 2023 12:14:09 -0600


On Sat, 09 Dec 2023 11:58:15 -0500, Kamal Dasu wrote:
> From: Kamal Dasu <kdasu@broadcom.com>
> 
> With newer sdio controller core used for 74165b0 we need to update
> the compatibility with "brcm,bcm74165b0-sdhci".
> 
> Signed-off-by: Kamal Dasu <kdasu@broadcom.com>
> ---
>  .../devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml         | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:25:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.example.dts'
Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:25:1: found a tab character that violates indentation
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:25:1: found a tab character that violates indentation
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231209165816.39044-1-kamal.dasu@broadcom.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


