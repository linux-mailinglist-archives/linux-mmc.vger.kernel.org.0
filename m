Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773ED47FD5A
	for <lists+linux-mmc@lfdr.de>; Mon, 27 Dec 2021 14:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhL0NcL (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 Dec 2021 08:32:11 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39418
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234010AbhL0NcI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:32:08 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8EC803F07F
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640611922;
        bh=DQgu+c4s6Y8JybTg+Dkanjn2+HAERoucENiRdMztxAI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=AB5CxL2Tv006+n7YL0/Sj8CjOlhCEFIpZ3yXZIfmOviIi0IgabgpnNVSnWn13H4XD
         umxrzjIL19yDaEdFwocaZtrl5ZZ2DL+9gWpSKUKDWKlwBmw57d4DF4pGyKL8+Aws66
         HsaO9oHJzUBVCpmFL5mmkgeqndJEhbJxKba+LBNMqgovyRsAoV5do2r6iETSsZg/Pw
         rQvjMlq5DjMCetDRxAMThODI19DhVv75cuJhQTYEYVv0/mK8yiUWGZDTUnXGA/bJ/r
         ZYHqivllWI797plJ0oogHyJ/TR3HCUW/rco87q7QtyHXMtTJDIcymudNJx8tLxEVIJ
         5o1Mm80Jy3Tjg==
Received: by mail-lj1-f199.google.com with SMTP id c31-20020a2ebf1f000000b0022d87a28911so4833361ljr.1
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:32:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DQgu+c4s6Y8JybTg+Dkanjn2+HAERoucENiRdMztxAI=;
        b=pbfU2pQ8q4c3vSQOn+D6siLcMpUwAJMwE0tWVPsaqlt5odp/TrEpwik+4K6ssJ4qZa
         oBKfLbGlhjg0t3MbsIfT42DuiF5k+8NBD1w4ZJeU9KeAMrNFEMIJ2tGgQA0+cUjEamWZ
         e/e7IzX4ZlnzdE/TEqUmaqZxXZS4ExYcdNCR0unuVRxsYlSjBfEOZuMjRjNtllZ4qAFt
         qxnWicnAvZolZjzrBWZFZ16qRNZIVlHreYd4W7QBK9QyA8bQ0n5GvLlNPTPiNO62pPtI
         gmry8qgeumPH6w35Z6VMm7AQzTL9nNop87V6bIx8oJRd7xuS7Y1tLrnwejg7GNl8ERZJ
         CGjg==
X-Gm-Message-State: AOAM533IcruVf08oOA/ZZZNPlIwW9qXk1QKfeXzNlSUsqCI3oxzjl7WM
        vmZI2S4Lv5BfFZegFWKxyMR15tnjRYCNc+WJ0NcaTJFUGJUV81MqOAJzcjZ7uRoyIxLZH0VwEmq
        UM1Br2/9dsg/sw6KVEZvPaCfb1yu83vb0TlFXoQ==
X-Received: by 2002:a19:ad41:: with SMTP id s1mr8236568lfd.169.1640611921889;
        Mon, 27 Dec 2021 05:32:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz0Q4U7LIWpMdBq7LHQ60Uwk0l50gaJJ6gA+g47QhV12twTncFZtNPYDuX5cQQqf0Bn6AzCCA==
X-Received: by 2002:a19:ad41:: with SMTP id s1mr8236549lfd.169.1640611921619;
        Mon, 27 Dec 2021 05:32:01 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d14sm1433510lfg.18.2021.12.27.05.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:32:00 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 00/19] arm/arm64/dt-bindings: altera/intel: fix DTS and dtschema
Date:   Mon, 27 Dec 2021 14:31:12 +0100
Message-Id: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

Partial cleanup of Altera/Intel ARMv7 and ARMv8 DTS and bindings.

The patches are independent, unless touching same files (e.g.
bindings/arm/altera.yaml).

Best regards,
Krzysztof

Krzysztof Kozlowski (19):
  dt-bindings: vendor-prefixes: add Enclustra
  dt-bindings: altera: document existing Cyclone 5 board compatibles
  dt-bindings: altera: document Arria 5 based board compatibles
  dt-bindings: altera: document Arria 10 based board compatibles
  dt-bindings: altera: document VT compatibles
  dt-bindings: altera: document Stratix 10 based board compatibles
  dt-bindings: intel: document Agilex based board compatibles
  dt-bindings: clock: intel,stratix10: convert to dtschema
  dt-bindings: mmc: synopsys-dw-mshc: integrate Altera and Imagination
  ARM: dts: arria5: add board compatible for SoCFPGA DK
  ARM: dts: arria10: add board compatible for Mercury AA1
  ARM: dts: arria10: add board compatible for SoCFPGA DK
  arm64: dts: stratix10: add board compatible for SoCFPGA DK
  arm64: dts: stratix10: move ARM timer out of SoC node
  arm64: dts: stratix10: align mmc node names with dtschema
  arm64: dts: stratix10: align regulator node names with dtschema
  arm64: dts: agilex: add board compatible for SoCFPGA DK
  arm64: dts: agilex: add board compatible for N5X DK
  arm64: dts: agilex: align mmc node names with dtschema

 .../devicetree/bindings/arm/altera.yaml       | 46 ++++++++++++++++---
 .../bindings/arm/intel,socfpga.yaml           | 26 +++++++++++
 .../bindings/clock/intc_stratix10.txt         | 20 --------
 .../bindings/clock/intel,stratix10.yaml       | 35 ++++++++++++++
 .../devicetree/bindings/mmc/img-dw-mshc.txt   | 28 -----------
 .../bindings/mmc/socfpga-dw-mshc.txt          | 23 ----------
 .../bindings/mmc/synopsys-dw-mshc.yaml        |  5 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 .../boot/dts/socfpga_arria10_mercury_aa1.dts  |  2 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi  |  2 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts    |  2 +-
 .../boot/dts/altera/socfpga_stratix10.dtsi    | 21 +++++----
 .../dts/altera/socfpga_stratix10_socdk.dts    |  3 +-
 .../altera/socfpga_stratix10_socdk_nand.dts   |  3 +-
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  2 +-
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |  1 +
 .../dts/intel/socfpga_agilex_socdk_nand.dts   |  1 +
 .../boot/dts/intel/socfpga_n5x_socdk.dts      |  1 +
 18 files changed, 129 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/intel,socfpga.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/intc_stratix10.txt
 create mode 100644 Documentation/devicetree/bindings/clock/intel,stratix10.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/img-dw-mshc.txt
 delete mode 100644 Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt

-- 
2.32.0

