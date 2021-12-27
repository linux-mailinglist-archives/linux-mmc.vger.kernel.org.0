Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31547FD66
	for <lists+linux-mmc@lfdr.de>; Mon, 27 Dec 2021 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhL0NcR (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 27 Dec 2021 08:32:17 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:39450
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234122AbhL0NcM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Dec 2021 08:32:12 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3CFE03F206
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 13:32:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640611931;
        bh=MHp/uWCH5GnB9eOTk5ejo8HU97THJSgA4dspcnuZXTw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uoedOpKbAdCfIj1iWIkZNcRe15xqgsDp86g8FwHHgN2hCBmZ6Dk5hU6a0Fh0aaK9W
         uooRS0G8miK1e09iawuEfoM4jgpKD42SA8PMQTmWFpL3AsdTOgvR0GOVa5OM6LbTOX
         +fScz5acU5o3msE5NOFQHawHT5c7wwEapUSdyaL3S7cpUlvC5xu8tPa1ul7qyGoBwQ
         XfSSGFeAJlhnaT9kZrd3SWnFavVzbCvpymYYpcM9VFL84ca1RSP54V9qs4+pKAaLMc
         lwI76TBlKQiN2LNMOuVnoi6nmJpCmHF1DESbCKIVUyxvRYtVJeL8i8do4bmNXZ4qCt
         oar/aFTdEbVsg==
Received: by mail-lj1-f200.google.com with SMTP id u9-20020a05651c140900b0022dd165d92bso1402971lje.4
        for <linux-mmc@vger.kernel.org>; Mon, 27 Dec 2021 05:32:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHp/uWCH5GnB9eOTk5ejo8HU97THJSgA4dspcnuZXTw=;
        b=Q1WjdAX7c8Aa6AtL3BFJg/yycVVVsjxKH0xzhQHme37EyskG0b6v3DMLdC+L8d5q44
         LfkR/9OU4MOa/c05TU3zFpnftAJbmiQE0EL/ka3lTgzGKy9QE/9Rf1MOv4VciXX7Vg+2
         OEaa7Gw5viQ9/AMcMbOwQQrU+hi/RjVa5fgx6s1xavT92wi0hWazOuMCZkduQPpSUI6H
         onS8pcrehLtRqOkfx3vNmQfM60KI5NtSF9g7F0ksnX1cEqxoDuoMbjorz2dfxouS0ypI
         Cnhvpp4S3homlAuAXDW/qNNtc94O76XDW02gLJdsNUvn94cVQvQ9qDiQblhT6tPCSVG3
         pJzA==
X-Gm-Message-State: AOAM531FsoUaeKsKvzoTUh7fcVz08eC/YRcVpmyijUbkJj6Y1YH1tRz4
        5HGuMV8iUOSuDguAxaQNQXadzwxdXCJvyaQC5HZXGNw06ucaFRF/o8vaxIyNakNbUAWboLTMMBU
        Aa6soYHhz6QKXaS96hy+sGWpvC0rLv7DzpASlhw==
X-Received: by 2002:ac2:4828:: with SMTP id 8mr16033495lft.477.1640611929490;
        Mon, 27 Dec 2021 05:32:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw77J68nGFhgLXCA+eXYxvqfScF69sInQCoFPQykWUbx1r+RPtCS3P0q/HkVn3cmdzNIMd/cw==
X-Received: by 2002:ac2:4828:: with SMTP id 8mr16033482lft.477.1640611929332;
        Mon, 27 Dec 2021 05:32:09 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id d14sm1433510lfg.18.2021.12.27.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 05:32:08 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dinh Nguyen <dinguyen@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 05/19] dt-bindings: altera: document VT compatibles
Date:   Mon, 27 Dec 2021 14:31:17 +0100
Message-Id: <20211227133131.134369-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
References: <20211227133131.134369-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add new compatible for SoCFPGA VT boards/designs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 963c83904010..f4e07a21aaf5 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -43,6 +43,11 @@ properties:
           - const: altr,socfpga-cyclone5
           - const: altr,socfpga
 
+      - description: SoCFPGA VT
+        items:
+          - const: altr,socfpga-vt
+          - const: altr,socfpga
+
 additionalProperties: true
 
 ...
-- 
2.32.0

